INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSC101', 
				'Introduction to Computer Programming', 
				'This is an introductory course in Computer Science. The main objective of this course is to help the student develop a strong foundation of computer programming using C++. The programming concepts that will be covered in the class are variable, data types, input, output, arithmetic operation, control structures, logical operation, conditional statements, iterative statements, array, function, string. Each lecture would involve solving a number of programming problems using the computer. After successful completion of the course a student will be able to break down a complex programming problem into smaller parts, solve them and write the solution in C++.',
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE104', 
				'Electrical Circuit Analysis', 
				'The study of electrical circuits is an integral part of the Electrical and Computer Engineering curriculum.
Basic understanding of the components of electrical circuits is essential for the study of any electrical
and electronic devices. The topics covered in this course are: Ohm’s law, Kirchhoff’s laws, network
theorems, series and parallel dc circuits, capacitors and inductors, sinusoids and phasors, series and
parallel ac circuits. Particular emphasis is given to the dc circuit analysis. The Lab segment of the course
will be used to gain hands-on experience in electrical measurements of different circuit components.
The laws and the relations derived in the theory segment will be verified at the Lab. Upon successful
completion of this course students will be able to explain the basic concepts and parameters associated
with all the various circuit components, apply Kirchhoff’s laws and network theorems, and analyze series
and parallel circuits.', 
'4',
'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE201',
				'Discrete Mathematics', 
				'This course covers elementary discrete mathematics required for computer science and engineering students. Emphasis is placed on mathematical definitions and proofs as well as methods of application. Topics include a review of set theory, formal logic notation and operations, methods of proof, induction, permutations and combinations, basic and advanced counting techniques, recurrence relations, generating functions, graph theory and finite state machines.', 
                '3',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE203',
				'Data Structure', 
				'Data representation and storage in elementary data structures like arrays and linked lists (both singly linked lists and doubly linked lists). Abstract Data Types (ADT): Stack, Queue, Priority Queue. Comparative analysis of different implementations of ADTs (Array based and linked list based).  Binary Search Tree (including red/black trees), Heap, Efficient  Priority  Queue (Heap based).  Complexity analysis of dictionary operations (insertion/deletion/search) on ADTs. Use of data structures in the design and implementation of smart searching and sorting algorithms (Binary search, Heap sort). Graphs (Connectivity graph, Directed and Undirected graph).', 
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE204',
				'Digital Logic Design', 
				'Overview of digital and analog systems, and the basic building blocks of digital systems. Discussion on combinational logic: number systems, logic gates, Boolean algebra, arithmetic circuits, field programmable logic gates. Design techniques for sequential circuits: latches, register, counters, MSI logic circuits, flip-flops, A-D and D-A converters, IC logic families, memory devices, PLD, ASIC, FPGA. The accompanying LAB course provides students with a hands-on-experience in the design and operation of sequential circuits using various flip-flops.', 
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE210',
				'Electronics I', 
				'Basic Semiconductor and pn-junction theory: Energy Bands, Conductors, Insulators and semiconductors, p-type and n-type semiconductors, Majority and minority carriers, Drift and Diffusion Current. P-N junction as a circuit element: operational principle of p-n junction diode, contact potential, current-voltage characteristics of a diode, simplified dc and ac diode models, dynamic resistance and capacitance. Diode applications: Half wave and full wave rectifiers, rectifiers with filter capacitor, clamping and clipping circuits. Zener diode: characteristics of a zener diode, zener shunt regulator. Introduction to power diodes: schottky diode, tunnel diode, gun diode, varactor diode. Bipolar junction Transistors (BJT): Basic structure, BJT characteristics and regions of operation, BJT Currents, BJT Terminal Voltages, BJT voltage amplification. Bipolar Junction Transistor Biasing: The dc load line and bias point, biasing the BJT for discrete circuits, small signal equivalent circuit models, h parameters. Single-stage BJT amplifier circuits and their configurations: Voltage and current gain, input and output impedances. Introduction to multistage amplifiers; Power amplifiers: Class A, Class B and Class C amplifiers; Introduction to power transistors: Field-Effect Transistors (FET), Junction Field-Effect Transistors (JFET), Metal-Oxide-Semiconductor Field-Effect-Transistor (MOSFET), FET Biasing and Small-Signal Analysis, Metal Semiconductor Field Effect Transistor(MESFET), Insulated Gate Bipolar Transistors (IGBTs), Static Induction Transistors (SITs) and COOLMOS. Introduction to operational amplifier (Op-Amp); Electronic circuit analysis using PSPICE.', 
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE211',
				'Algorithms', 
				'Techniques and principles of algorithms design including divide-and-conquer and greedy algorithms. Complexity (worst and average case) analysis and their associated asymptotic notations (Theta, Big O, Omega). Iterative sorting algorithms: Bubble sort, insertion sort. Recursive sorting: merge sort, quick sort, heap sort. Sorting in linear time: counting/radix sort. Decision tree analysis: N*logN bound on comparison based sorting.  Algorithms for graph problems: Shortest path (Dijkstra), minimum spanning trees (MST algorithms: Kruskal, Prim). Hashing. Discussion on NP-class problems (e.g. Travelling Salesman Problem).', 
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE213',
				'Object oriented Programming', 
				'This course introduces the concepts of object-oriented programming to students with a background in the procedural paradigm. Design principles and patterns of modularity and abstraction in object-oriented programming are discussed in detail. Basic concepts covered: objects, classes, constructors, destructors, abstract data types, composition, inheritance, polymorphism, overloading, function chaining. More advanced topics include:  friend and virtual functions, template functions and classes, using standard library classes as building blocks for an application. Languages used are C++, C# or Java.', 
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE214',
				'Computer Organization and Architecture', 
				'Introduction to computer systems, their various components and functions. Topics covered include memory organization and management, computer arithmetic, hardware design algorithms and I/O. Concepts in CPU architecture (RISC, CISC) , instruction cycle, instruction pipelining, control unit design, and multicore processor organization are also covered.', 
                '3',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE216',
				'Microprocessor, Interfacing and Assembly Language ', 
				'Introduction to the 80x86 families of microprocessors and the organization of an IBM PC. Topics covered: Microprocessor architecture, addressing mechanism, Instruction set, Instruction format;  Assembly language programming: assembling, linking, running and debugging programs; Program control instructions and interrupts; Microprocessor interfacing with memory and other devices; 8086 based system design, Programmable peripheral interface: 8255A, 8251A, DMA controller 8237, Interrupt controller 8259A; Overview of advanced processors: 80386, Pentium and Multicore processors.', 
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE303',
				'Database Management ', 
				'An introduction to database design and the use of database management systems. The course includes detailed coverage of the development process, database architectural principles, relational algebra and SQL using Oracle or SQL Server. Other key database topics covered are data modelling (E-R model, relational data model, integrity constraints, data model operations, normalization, object oriented data modelling), database security, administration and distributed systems.', 
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'MAT104',
				'Calculus and Analytical Geomtery', 
				'This is one of the foundation courses offered by the university, which fulfills the requirement of foundation in “Numeracy”. This course is mandatory for the students who wish to major in Computer Science and Engineering.

Topics include: Functions and their visualization, limits, and continuity; Differential calculus, differentiation of product and quotient; Successive differentiation. Additional techniques of integration. Interpretations of the derivative, applications of the derivative to geometry, mechanics, marginality and optimization. Newton’s method. Introduction to modeling; Integral calculus, integration by parts; Definite integral, interpretations and properties of the definite integral, applications of the definite integral to geometry, mechanics, economics and modeling. Approximating definite integral, approximation errors and Simpson’s rule, improper integrals. Taylor polynomials and series, convergence of series, finding and using Taylor’s series, indeterminate forms, Fourier series. First order differential equations: Slope fields, Euler’s method, separation of variables, linear equations, applications and modeling.', 
                '3',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE212',
				'Probability & Statistics for Science and Engineering', 
				'Recently, statistics is becoming increasingly important in understanding physical phenomenon. This is mainly because of two reasons: a) the problems are becoming extremely complicated, so that application of physical laws is becoming increasingly difficult b) in many cases, even the physical laws are not clearly defined or understood. In all these cases, researchers rely upon statistical methods to obtain some insight into the problem. The course "MAT 212 Probability and Statistics have been designed as a first course of Statistics for the students who want to graduate from the department of Electrical and Electronic Engineering. As such, no prior knowledge of statistics is needed. But knowledge of Differential and Integral Calculus is required. It shall be assumed that all students have the necessary background in these branches of mathematics. Students are advised to procure a scientific calculator for use in the class. The calculator must have the function to calculate factorial of an integer, exponential calculation, power calculation and preferably compute permutation and combination calculations. Students may use programmable calculators in examinations.

Topics covered include discrete and continuous random variables; probability concepts; discrete and continuous distributions; Binomial, Poisson, Normal, Exponential distributions; moments and moment generating functions, joint probability distributions; sampling distributions; confidence intervals; Least Square regression; hypothesis testing; analysis of variance.', 
                '3',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'PHY101',
				'University Physics I', 
				'This is one of the courses offered by the university, which fulfills the requirement of Basic Sciences for graduation from the university. This course is mandatory for the students who wish to major in Physics, Mathematics, and Computer Science (CS) or in any Engineering Subject. The course forms a one-year standard course in University Physics. There is no prerequisite for this course though it is highly recommended that the students must have a fair amount of background in mathematics. Specially, knowledge of Calculus will be required sometimes. The course will lay emphasis mainly upon physical description of processes rather than complicated mathematical derivations.

Topics include – Mechanics: vectors; motion in one and two-dimension; Newton’s Laws of Motion; work, energy and momentum; rotation; elasticity. Heat and thermodynamics: temperature and heat; laws of thermodynamics. Waves and acoustics: periodic and simple harmonic motion; mechanical waves and vibrating bodies; acoustic phenomena. Optics: nature and propagation of light; reflection and refraction; lenses and optical instruments; interference and diffraction.', 
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'PHY102',
				'University Physics II', 
				'This is one of the courses offered by the university, which fulfills the requirement of Basic Sciences for graduation from the university. This course is mandatory for the students who wish to major in Computer Science (CS) or in any Engineering Subject. The course forms a one-year standard course in University Physics. There is no prerequisite for this course though it is highly recommended that the students must have a fair amount of background in mathematics. Specially, knowledge of Calculus will be required sometimes. The course will lay emphasis mainly upon physical description of processes rather than complicated mathematical derivations.

Topics covered are: Electricity and Magnetism – Coulomb’s Law, electric field, Gauss’ Law, electric potential, capacitance and dielectric, current, resistance, EMF, magnetic field, induction and inductance, DC circuits, alternating currents and circuits, electromagnetic waves; Electronics – network theorems, basic semiconductor concepts, semiconductor diode and rectifier circuits, bipolar transistor, FET, MOSFET, amplifier and operational amplifier.', 
                '4',
                'CSE'
);




select * from course;


INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'MAT301', 
				'Ordinary Differential Equations', 
				'Topics include:  First order ordinary differential equations (existence and uniqueness of solutions, solution techniques, direction fields and stability, modeling applications); Second and higher order linear equations (existence and uniqueness, fundamental set of solutions of homogeneous equations, Wronskian, reduction of order, equations with constant coefficients, method of undetermined coefficients, method of variation of parameters, solutions in series, Laplace transform method, modeling applications); Systems of linear differential equations (existence and uniqueness of solutions, eigenvalue method for homogeneous systems, method of variation of parameters for systems, Laplace transform method for systems, modeling applications). An introduction to nonlinear systems will be covered as well.', 
'4',
'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'MAT203', 
				'Linear Algebra: Vectors and Metrics', 
				'Topics include geometry and algebra of vectors and matrices, unit vectors, dot and cross products, elementary concepts of a matrix, row operations, solutions of a system of linear equations; Systems of linear equations and matrices, vector spaces and subspaces, linear dependence and independence, dimensions and bases, linear transformations and matrices, eigenvalues and eigenvectors, changes of coordinates, orthogonality, diagonalization.', 
'4',
'CSE'
);





	
