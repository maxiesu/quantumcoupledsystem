#include "EigenvalueProblem.h"
#include "LinearCombinationOfOrbitals.h"
#include "SimulationEnvironment.h"
#include "TiberModule.h"
#include "TiberLinearSystem.h"
#include "SimulationOptions.h"

#include <petsc_matrix.h>

#include "Messages.h"
#include <signal.h>


using namespace Constants;

namespace
{
  bool compare_eigen_energy(const EigenvalueProblem::eigen_state& state1,
      const EigenvalueProblem::eigen_state& state2)
  {
    if ((state1.particle == "hl") && (state1.particle == state2.particle))
      return (state2.energy < state1.energy);

    return(state1.energy< state2.energy);
  }
}


LinearCombinationOfOrbitals*
LinearCombinationOfOrbitals::create(const ModelOptions& options)
{
  return(new LinearCombinationOfOrbitals(options));
}





LinearCombinationOfOrbitals::~LinearCombinationOfOrbitals(void)
{
  delete(_H_lcqo_real);
  delete(_H_lcqo_imag);
  delete(_S_lcqo_real);
  delete(_S_lcqo_imag);
}




LinearCombinationOfOrbitals::LinearCombinationOfOrbitals(
                              const ModelOptions& options)
 : EigenvalueProblem(options),
   _H_lcqo_real(nullptr),
   _H_lcqo_imag(nullptr),
   _S_lcqo_real(nullptr),
   _S_lcqo_imag(nullptr),
   _single_dot_hamiltonian(nullptr),
   _total_system_hamiltonian(nullptr)
{
  _H_lcqo_size = 0;
}





void LinearCombinationOfOrbitals::do_init()
{

  //single dot---------------
  if(has_option("single_dot_hamiltonian"))
  {
    std::string quantum_model;
    quantum_model = get_option("single_dot_hamiltonian" , "");
    _single_dot_hamiltonian =
                dynamic_cast<EigenvalueProblem*>(find_simulation(quantum_model));
    if("_single_dot_hamiltonian" == nullptr)
      throw InitFailedException("LinearCombinationOfOrbitals: "
                             "invalid single_dot_hamiltonian" + quantum_model);
  }
  else
    throw InitFailedException("LinearCombinationOfOrbitals: "
                                  "single_dot_hamiltonian must be defined\n");




  //total system------------
  if(has_option("total_system_hamiltonian"))
  {
    std::string quantum_model;
    quantum_model = get_option("total_system_hamiltonian" , "");
    _total_system_hamiltonian =
           dynamic_cast<EigenvalueProblem*>(find_simulation(quantum_model));

    if("_total_system_hamiltonian" == nullptr)
      throw InitFailedException("LinearCombinationOfOrbitals: "
                           "invalid total_system_hamiltonian" + quantum_model);
  }
  else
    throw InitFailedException("LinearCombinationOfOrbitals:"
                         " total_system_hamiltonian must be defined\n");



  if (_H_lcqo_real == nullptr)
  {
    _H_lcqo_real = new libMesh::PetscMatrix<double>(get_solver_communicator());
  }

  if (_H_lcqo_imag == nullptr)
  {
    _H_lcqo_imag = new libMesh::PetscMatrix<double>(get_solver_communicator());
  }

  if (_S_lcqo_real == nullptr)
  {
    _S_lcqo_real = new libMesh::PetscMatrix<double>(get_solver_communicator());
  }

  if (_S_lcqo_imag == nullptr)
  {
    _S_lcqo_imag = new libMesh::PetscMatrix<double>(get_solver_communicator());
  }


  int shift_size = 0;
  get_parameter("number_of_dots", shift_size);
  _shift_x.resize(shift_size);

}




void LinearCombinationOfOrbitals::do_solve(void)
{
  do_solve_for_kpoint(Point(0.0));
}




void LinearCombinationOfOrbitals::do_solve_for_kpoint(const Point& kpoint)
{
  set_k_point(kpoint);

  //_single_dot_hamiltonian->solve_for_kpoint(k_point);

  //we don't solve the total_system_hamiltonian, we just
  //assemble the total hamiltonian
  _total_system_hamiltonian->set_k_point(kpoint);
  _total_system_hamiltonian->assemble();

  const ModelOptions& options = get_options();

  Utils::Timer tt;

  assemble(options);    //assemble the lcqo generalized eigenvalue problem

  std::cerr<<__LINE__<<" "<<__FILE__<<" ASSEMBLE time: "<<tt.elapsed_string()<<"\n\n";

  std::cerr<<"dim(_H_lcqo_real) = "<<_H_lcqo_real->n()<<"\n\n";

  _H_lcqo_size = _H_lcqo_real->n();

  tt.reset();

  //inizialize local solution containers
  initialize_solution_container(_H_lcqo_size);

  //inizialize total system solution containers
  _total_system_hamiltonian->initialize_solution_container
                                            (_H_lcqo_size);

  solve_eigen_value_problem(_H_lcqo_size);  //solve generalized eigenvalue problem

  std::cerr<<"\n\n"<<__LINE__<<" "<<__FILE__<<" SOLVE time: "<<tt.elapsed_string()<<"\n\n";

}



//Assemble the LCQO H and S matrices
void LinearCombinationOfOrbitals::do_assemble(const ModelOptions& options)
{
  calculate_shift();
  //m = |M| x n    with |M| number of points and n number of
  //single-particle states used as basis function
  unsigned int number_of_repetitions = _shift_x.size();

  //take solution from _single_dot_hamiltonian
  const std::vector<eigen_problem_solution>& single_dot_sol =
      _single_dot_hamiltonian->get_solution();

  unsigned int basis_size = single_dot_sol.size();//number of wave functions for dot
  unsigned int m = basis_size * number_of_repetitions; //dimension of lcqo system

  //initialize the H_lcqo and S_lcqo matrices with the
  //proper dimension
  _H_lcqo_real->init(m , m , m , m, m);
  _H_lcqo_imag->init(m , m , m , m, m);
  _S_lcqo_real->init(m , m , m , m, m);
  _S_lcqo_imag->init(m , m , m , m, m);



  size_t total_sys_dim = _total_system_hamiltonian->get_H_dim();

  //define the total system wave functions with the proper dimension
  std::vector<libMesh::Complex> total_basis_wave_function_a(total_sys_dim);
  std::vector<libMesh::Complex> total_basis_wave_function_b(total_sys_dim);

  for (int shift_i = 0; shift_i < number_of_repetitions; ++shift_i)
  {
    for (int shift_j = 0; shift_j < number_of_repetitions; ++shift_j)
    {
      if (std::abs(shift_i - shift_j) > 1)
        continue;

      for (int state_i = 0; state_i < basis_size; ++state_i)
      { //std::cerr<<__LINE__<<" "<<__FILE__<<" state_i = "<<state_i<<" shift_i = "<<shift_i<<" shift_j = "<<shift_j<<"\n\n";
        //set all the elements of the vector to 0
        std::fill(total_basis_wave_function_a.begin(),
            total_basis_wave_function_a.end(), 0);

        size_t sd_len_i = single_dot_sol[state_i].eigen_vector.size();

        for (size_t pos = 0; pos < sd_len_i; ++pos)
        {
          unsigned int shift_xi = _shift_x[shift_i];

          total_basis_wave_function_a[shift_xi + pos] =
              single_dot_sol[state_i].eigen_vector[pos];
        }

        for (int state_j = 0; state_j < basis_size; ++state_j)
        {
          std::fill(total_basis_wave_function_b.begin(),
              total_basis_wave_function_b.end(), 0);

          size_t sd_len_j = single_dot_sol[state_j].eigen_vector.size();

          for (size_t pos = 0; pos < sd_len_j; ++pos)
          {
            unsigned int shift_xj = _shift_x[shift_j];

            total_basis_wave_function_b[shift_xj + pos] =
                single_dot_sol[state_j].eigen_vector[pos];
          }

          Utils::Timer tt1;

          //calculate the current H element passing the two total system wave
          //functions for the product <phi_l | H_t | phi_k>
          libMesh::Complex current_H_element = 0;
          current_H_element = _total_system_hamiltonian->
              calculate_hamiltonian_matrix_element(
                  total_basis_wave_function_a,
                  total_basis_wave_function_b);
          if (state_j == 0 && state_i == 0 && shift_i == 0 && shift_j == 0)
            std::cerr<<__LINE__<<" "<<__FILE__<<" calculate_hamiltonian_matrix_element time: "<<tt1.elapsed_string()<<"\n\n";

          //calculate the row and column index to put the current element in the
          //exact position
          size_t row_index = 0;
          size_t column_index = 0;
          row_index = (shift_i * basis_size) + state_i;
          column_index = (shift_j * basis_size) + state_j;


          _H_lcqo_real->set(row_index , column_index , current_H_element.real());
          _H_lcqo_imag->set(row_index , column_index , current_H_element.imag());

          tt1.reset();

          libMesh::Complex current_S_element = 0;
          current_S_element = _total_system_hamiltonian->
              scalar_product(total_basis_wave_function_a,
                  total_basis_wave_function_b);

          if (state_j == 0 && state_i == 0 && shift_i == 0 && shift_j == 0)
             std::cerr<<__LINE__<<" "<<__FILE__<<" scalar_product time: "<<tt1.elapsed_string()<<"\n\n";

          _S_lcqo_real->set(row_index , column_index , current_S_element.real());
          _S_lcqo_imag->set(row_index , column_index , current_S_element.imag());
        }
      }
    }
  }
  _H_lcqo_real->close();
  _H_lcqo_imag->close();

  _S_lcqo_real->close();
  _S_lcqo_imag->close();

  _H_lcqo_real->print_matlab("H_lcqo_real.m");
  _H_lcqo_imag->print_matlab("H_lcqo_imag.m");

  _S_lcqo_real->print_matlab("S_lcqo_real.m");
  _S_lcqo_imag->print_matlab("S_lcqo_imag.m");
}








void LinearCombinationOfOrbitals::do_calculate_density_at_k(DofField& Density)
{
}






void LinearCombinationOfOrbitals::solve_eigen_value_problem
                                  (unsigned int ev_number)
{

  EigenSolver::prepare_slepc(get_solver_communicator().get());

  copy_H_to_solver( );
  _haveS = true;

  if (_haveS)  copy_S_to_solver( );


  if (ev_number > _H_lcqo_size)
    throw SolveFailedException("Number of requested eigenvalues is "
                                "bigger than the Hamiltonian size");

  parse_options();


  EigenSolver::SLEPCoptions slep_opt;

  slep_opt.solver_type = solver_opt.solver;

  slep_opt.H_file_name = "H.out";

  slep_opt.S_file_name = "S.out";

  slep_opt.eps_max_it =  solver_opt.max_iteration_number;

  slep_opt.spectral_trans = solver_opt.spectral_trans;

  slep_opt.read_matrix_from_file = false;

  slep_opt.matrix_output = solver_opt.dump_on_file;

  slep_opt.pc_type = solver_opt.preconditioner;

  slep_opt.st_ksp_type = solver_opt.st_ksp_type;

  slep_opt.use_deflation_space =
      get_solver_options().get_option("use_deflation_space", true);


  slep_opt.monitor = solver_opt.monitor;

  slep_opt.spectrum_inversion_tolerance = solver_opt.spectrum_inversion_tolerance;

  //EigenSolver::check_matrices(1e-10,true);

  slep_opt.eps_tolerance = solver_opt.eigen_solver_tolerance;


  slep_opt.ev_number = ev_number;

  slep_opt.spectrum_shift  = 0.0;


  //std::cout << "  (EFA) Solving using guess (Hartree) " << st_shift_value << endl;

  bool foundall = false;

  while (!foundall)
  {

    int result;

    if (_haveS)
      result = EigenSolver::eig_value_problem_general(slep_opt);
    else
      result = EigenSolver::eig_value_problem(slep_opt);

    if (result !=0 )
      throw SolveFailedException("Eigensolver problem\n");

    foundall = read_SLEPC_solution();

    slep_opt.spectrum_shift = get_new_spectrum_shift();
    slep_opt.ev_number = solver_opt.number_of_eigenstates;
  }

  int result = EigenSolver::clear_slepc();


}






void LinearCombinationOfOrbitals::parse_options(void)
{
  const ModelOptions& sol_opt = get_solver_options();

  solver_opt.solver = sol_opt.get_option("solver","lapack");

  if ( !(solver_opt.solver == "krylovshur" ||
         solver_opt.solver == "arnoldi" ||
         solver_opt.solver == "arpack" ||
         solver_opt.solver == "lapack" ) )
    throw InitFailedException("Invalid solver " +solver_opt.solver);


  solver_opt.max_iteration_number = sol_opt.get_option
                                    ("max_iteration_number",30000);

  solver_opt.eigen_solver_tolerance  = sol_opt.get_option
                                       ("eigen_solver_tolerance",1e-9);

  solver_opt.spectral_trans = sol_opt.get_option
                              ("spectral_transformation","shift_and_invert");


  solver_opt.number_of_eigenstates   = sol_opt.get_option
                                       ("number_of_eigenstates", 6);

  solver_opt.spectrum_shift = sol_opt.get_option("guess",0.0);


  solver_opt.monitor = sol_opt.get_option("monitor", false);


  solver_opt.spectrum_inversion_tolerance = sol_opt.get_option
                        ("spectrum_inversion_tolerance", 1e-8);

  //cerr <<  solver_opt.Dirichlet_bc_everywhere << "\n";


  solver_opt.dump_on_file = get_option("dump_HS_on_files", true);

  {

    solver_opt.st_ksp_type = std::string("bcgsl");

    if (_H_lcqo_size == 1)
      solver_opt.preconditioner = std::string("lu");
    else
      solver_opt.preconditioner = std::string("jacobi");

  }

  solver_opt.preconditioner =  sol_opt.get_option
                               ("pc_type", solver_opt.preconditioner);

  solver_opt.st_ksp_type =  sol_opt.get_option("ksp_type",solver_opt.st_ksp_type);

  if ((this->get_solver_communicator().size() == 1) &&
                    (solver_opt.preconditioner == "lu"))
  {
    solver_opt.st_ksp_type = std::string("preonly");
  }

}







void LinearCombinationOfOrbitals::copy_matrix_to_solver(const char matrix)
{
  // our problems are square

  libMesh::PetscMatrix<Number>* H_lcqo_real = nullptr;
  libMesh::PetscMatrix<Number>* H_lcqo_imag = nullptr;

  if (matrix == 'H')
  {
    H_lcqo_real = static_cast<libMesh::PetscMatrix<Number>* >(_H_lcqo_real);
    H_lcqo_real->close();

    H_lcqo_imag = static_cast<libMesh::PetscMatrix<Number>* >(_H_lcqo_imag);
    H_lcqo_imag->close();
  }
  else if (matrix == 'S')
  {
    H_lcqo_real = static_cast<libMesh::PetscMatrix<Number>* >(_S_lcqo_real);
    H_lcqo_real->close();

    H_lcqo_imag = static_cast<libMesh::PetscMatrix<Number>* >(_S_lcqo_imag);
    H_lcqo_imag->close();
  }


  // the first local index
  const int start = H_lcqo_real->row_start();
  const int end   = H_lcqo_real->row_stop();

  const int local_size = end - start;

  // diagonal nonzeros
  std::vector<int> d_nnz(local_size);
  // off-diagonal nonzeros
  std::vector<int> o_nnz(local_size);

  // we strongly assume H and S have the same partitioning
  const int offset = H_lcqo_real->row_start();

  for (int i = start; i < end; ++i)
  {
    PetscInt ncols_r = 0, ncols_i = 0;
    const PetscInt *row_r, *row_i;
    PetscErrorCode ierr;
    //const PetscReal *values_r, *values_i;

    ierr = MatGetRow(H_lcqo_real->mat(), i, &ncols_r, &row_r, PETSC_NULL);

    //if (matrix == 'H')
    ierr = MatGetRow(H_lcqo_imag->mat(), i, &ncols_i, &row_i, PETSC_NULL);

    int diag = 0;
    int offdiag = 0;

    for (int j = 0; j < ncols_r; ++j)
    {
      if ((row_r[j] < start) || (row_r[j] >= end))
        offdiag++;
      else
        diag++;
    }

    for (int j = 0; j < ncols_i; ++j)
    {
      if ((row_i[j] < start) || (row_i[j] >= end))
        offdiag++;
      else
        diag++;
    }

    d_nnz[i - offset] = diag;
    o_nnz[i - offset] = offdiag;

    ierr = MatRestoreRow(H_lcqo_real->mat(), i, &ncols_r, &row_r, PETSC_NULL);

    //if (matrix == 'H')
    ierr = MatRestoreRow(H_lcqo_imag->mat(), i, &ncols_i, &row_i, PETSC_NULL);
  }

  int size_matrix = _H_lcqo_real->n();
  EigenSolver::preallocate_matrix(matrix, size_matrix, local_size, d_nnz, o_nnz);

  for (int i = start; i < end; ++i)
  {
    PetscInt ncols_r = 0, ncols_i = 0;
    const PetscInt *row_r, *row_i;
    PetscErrorCode ierr;
    const PetscReal *values_r, *values_i;

    ierr = MatGetRow(H_lcqo_real->mat(), i, &ncols_r, &row_r, &values_r);

    //if (matrix == 'H')
    ierr = MatGetRow(H_lcqo_imag->mat(), i, &ncols_i, &row_i, &values_i);

    std::set<unsigned int> idset;
    for (int j = 0; j < ncols_r; ++j)
      idset.insert(row_r[j]);
    for (int j = 0; j < ncols_i; ++j)
      idset.insert(row_i[j]);

    std::vector<unsigned int> column_ids;
    column_ids.reserve(idset.size());
    for (std::set<unsigned int>::iterator it(idset.begin());
                                    it != idset.end(); ++it)
      column_ids.push_back(*it);


    std::vector<Complex> complex_values;
    complex_values.reserve(column_ids.size());

    std::vector<unsigned int> nonzero_ids;
    nonzero_ids.reserve(column_ids.size());

    for (int j = 0, k = 0, l = 0; j < column_ids.size(); ++j)
    {
      Complex value = 0.0;
      while ((k < ncols_r) && (row_r[k] < column_ids[j]))
        ++k;

      if ((k < ncols_r) && (row_r[k] == column_ids[j]))
        value += values_r[k];

      while ((l < ncols_i) && (row_i[l] < column_ids[j]))
        ++l;

      if ((l < ncols_i) && (row_i[l] == column_ids[j]))
        value += Complex(0.0, values_i[l]);

      if (value != 0.0)
      {
        nonzero_ids.push_back(column_ids[j]);
        complex_values.push_back(value);
      }
    }


    EigenSolver::insert_matrix_row(matrix, i, nonzero_ids, complex_values);


    ierr = MatRestoreRow(H_lcqo_real->mat(), i, &ncols_r, &row_r, &values_r);

    //if (matrix == 'H')
    ierr = MatRestoreRow(H_lcqo_imag->mat(), i, &ncols_i, &row_i, &values_i);
  }

  EigenSolver::finalize_matrix_assembly(matrix);
}







bool LinearCombinationOfOrbitals::read_SLEPC_solution(void)
{//
  /*
  1) Read all eigenvalues
  2) Sort the eigenvalues and select those we want
  3) Read eigenvectors that correspond to the eigenvalues we want
  4) normalize eigenfunctions
  5) calculate fermi energy for each state
  */


  //--------------------------------------------------------------------
  //how many solutions do we have from SLEPC?
  unsigned int number_of_converged_solutions;

  number_of_converged_solutions = EigenSolver::number_of_converged_eigenvalues();

  //--------------------------------------------------------------------
  //read eigenvalues
  //store also eigenvalue index for sorting

  std::vector<EigenvalueProblem::eigen_state>  ev(number_of_converged_solutions);
  double shift = EigenSolver::get_shift() * Constants::Hartree;


  //take a reference to the container of the eigenvalue problem solution
  std::vector<eigen_problem_solution>& solution = _solution;


  std::vector<eigen_problem_solution>& total_system_solution=
              _total_system_hamiltonian->get_solution();


  for (unsigned ind = 0; ind < number_of_converged_solutions; ind++)
  {
    ev[ind].energy =  EigenSolver::get_eigenvalue(ind) *
                                     Constants::Hartree; // + shift;

    ev[ind].index = ind;
  }

  // sorting of the solutions
  // we sort both electrons and holes by distance from the ground state

  std::sort(ev.begin(), ev.end(), compare_eigen_energy);

//  if (verbose() > 1)
//  {
    Messages m;
    std::ostringstream os;
    os << "converged eigenenergies (" << number_of_converged_solutions
        << "):";
    m.info(os.str());
    m.indent();

    os.str("");
    for (unsigned int i = 0; i < number_of_converged_solutions; ++i)
    {
      os << ev[i].energy << " ";
      if (i%8 == 7)
        os << "\n";
    }
    Messages::info(os.str());
    m.newline();
//  }



  for (unsigned int i = 0; i < number_of_converged_solutions; i++)
  {

    solution[i].eigen_energy = ev[i].energy;
    total_system_solution[i].eigen_energy = ev[i].energy;

    solution[i].statistics = "Fermi";
    total_system_solution[i].statistics = "Fermi";


    //read eigenvectors
    unsigned int solution_number = ev[i].index;

    EigenSolver::get_eigen_vector(solution_number, solution[i].eigen_vector);

    this->get_solver_communicator().allgather(solution[i].eigen_vector);

  }

  bool foundall = true;

  postprocess_solution();

  return foundall;
}


void LinearCombinationOfOrbitals::postprocess_solution(void)
{
  /*
   * This method construct construct the total system wave functions
   * and store them in _total_system_hamiltonian
   */

  //define the dimension of the total_system_wave_function
  size_t total_sys_dim = _total_system_hamiltonian->get_H_dim();


  //take a reference to _total_system_hamiltonian
  std::vector<eigen_problem_solution>& total_system_solution=
                                      _total_system_hamiltonian->get_solution();


  //take a reference to eigenvalue problem solution
  const std::vector<eigen_problem_solution>& solution = _solution;


  //take solution from _single_dot_hamiltonian
  const std::vector<eigen_problem_solution>& single_dot_sol =
                                            _single_dot_hamiltonian->get_solution();

  std::vector<libMesh::Complex> total_basis_wave_func(total_sys_dim);
  std::vector<libMesh::Complex> total_system_wave_func(total_sys_dim);

  size_t number_of_states = single_dot_sol.size();
  size_t number_of_rep = _shift_x.size();
  size_t m = number_of_states * number_of_rep;

  for (size_t i = 0; i < m; ++i)
  {
    std::fill(total_system_wave_func.begin(),
              total_system_wave_func.end(), 0);

    for (size_t shift_pos = 0; shift_pos < number_of_rep; ++shift_pos)
    {
      for (size_t state = 0; state < number_of_states; ++state)
      {
        size_t sd_len = single_dot_sol[state].eigen_vector.size();

        std::fill(total_basis_wave_func.begin(),
                  total_basis_wave_func.end(), 0);

        for (size_t pos = 0; pos < sd_len; ++pos)
        {
        size_t shift = _shift_x[shift_pos];

        total_basis_wave_func[shift + pos] =
              single_dot_sol[state].eigen_vector[pos];
        }

        size_t index = shift_pos * number_of_states + state;

        libMesh::Complex eigen_vector = solution[i].eigen_vector[index];

        for (size_t pos = 0; pos < total_basis_wave_func.size(); ++pos)
          total_system_wave_func[pos] += total_basis_wave_func[pos] * eigen_vector;
      }
    }
    //fill _total_system_hamiltonian with the total system wave functions
    total_system_solution[i].eigen_vector = total_system_wave_func;
  }

  //call some methods in EFA that cannot be implemented here because
  //of some inheritance issues
  _total_system_hamiltonian->postprocess_solution();
}


void LinearCombinationOfOrbitals::calculate_shift(void)
{ /*
  This method works well for a repetition of the basic well
  defined as
  barrier/well/barrier
  and the overlap must be equal for all the dots
  */

  size_t number_of_dots = _shift_x.size();
  size_t dot_size = _single_dot_hamiltonian->get_H_dim();

  if (number_of_dots <= 0)
  {
    throw InitFailedException("LinearCombinationOfOrbitals:"
        " control number of dots");
  }
  else if (number_of_dots == 1)
  {
    _shift_x[0] = 0;
  }
  else  //number_of_dots > 1
  {
    size_t total_system_size =_total_system_hamiltonian->get_H_dim();
    size_t system_without_overlap = 0;
    system_without_overlap = (dot_size * number_of_dots) - (number_of_dots - 1);

    if (total_system_size == system_without_overlap) //no overlap
    {
      for (size_t i = 0; i < number_of_dots; ++i)
      {
        _shift_x[i] = (dot_size - 1) * i;
      }
    }
    else //there is overlap
    {
      size_t number_of_overlaps = number_of_dots - 1;
      size_t overlap = 0;
      overlap = (system_without_overlap - total_system_size) / number_of_overlaps; std::cerr<<__LINE__<<" "<<__FILE__<<" single dot "<<dot_size<<" ; overlap "<<overlap<<" ; sys without overlap "<<system_without_overlap<<" ; total sys size "<<total_system_size<<" ; number of overlaps "<<number_of_overlaps<<"\n\n";

      for (size_t i = 0; i < number_of_dots; ++i)
      {
        _shift_x[i] = (dot_size - 1 - overlap) * i;
      }
    }
  }
}

