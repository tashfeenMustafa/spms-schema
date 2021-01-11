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









select * from course;



	