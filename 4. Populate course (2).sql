INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE303',
				'Database Management ', 
				'An introduction to database design and the use of database management systems. The course includes detailed coverage of the development process, database architectural principles, relational algebra and SQL using Oracle or SQL Server. Other key database topics covered are data modelling (E-R model, relational data model, integrity constraints, data model operations, normalization, object oriented data modelling), database security, administration and distributed systems.', 
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE307',
				'System Analysis and Design', 
				'This course examines the tools and techniques used for the design and analysis of information systems. Topics covered include: Systems and models; Project management; Tools for determining system requirements; data flow diagrams; decision table and decision trees; Systems analysis: systems development life cycle models. Object oriented analysis: use-case modeling, Unified Modeling Language. Feasibility analysis, Structured analysis; systems prototyping; system design and implementation: application architecture, user interface design. Front-end and backend design; database design; software management and hardware selection. Case studies of Information Systems', 
                '3',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE309',
				'Web Applications and Internet', 
				'This course serves as a comprehensive overview of web technologies and their usage. Essential topics such as OSI & TCP/IP architecture, Internet Routing, IP addressing & Domain Name System will be covered. Discussions will be held on popular browsers, HTML and Cascading Style Sheet, HTTP, HTTPS, FTP, Client and Server side scripts, Scripting (JavaScript, AJAX, XML) with jQuery libraries, Web Servers (IIS, Apache). Students will learn to design dynamic websites using ASP.NET with SQL server and PHP with My SQL. A brief overview of topics in web security such as cryptography, digital signatures, digital certificates, authentication & firewall will be provided.', 
                '3',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE310',
				'Electronics II', 
				'General frequency considerations for single stage or multi stage network: low and high frequency analysis and bode plot, multistage frequency effect and determining the cut-off frequencies. Operational Amplifiers (Op-Amp): Op-amp characteristics, open loop voltage gain, differential input voltage, inverting amplifier, inverting adder, non-inverting amplifier, voltage follower, differentiator, integrator, subtractor, CMRR, zero crossing and voltage level detector, hysteresis and their applications. Signal generators using op-amp: square, triangle, sawtooth and sine wave. DC performance: bias, offset and drift. AC performance: frequency parameter, unity-gain bandwidth, slew rate and noise. Various applications of op-amps: Precision Rectifier, MAV circuit, peak detector, precision clipper, Differential, Instrumentation and bridge amplifier. Active filter: frequency response of low pass, High pass, Band pass and Band stop filters for ideal and practical conditions; Band pass filter: narrow-band and wide-band filter. Feedback Amplifier: classification of amplifier as voltage, current, trans-resistance and trans-conductance amplifier, effect of feedback on amplifier bandwidth, condition of stability and the Nyquest criterion. Sinusoidal oscillator: the Barkhausen criterion, phase shift oscillator, general form of oscillator circuits; Colpitts oscillator, Hartley Oscillator, Crystal oscillator. Power Supplies (Voltage regulator), pnpn devices: SCR, SCS, DIAC, TRIAC, UJT. Timer circuit design, Multivibrators: Astable, monostable and bistable multivibrators.', 
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE313',
				'Compiler Construction', 
				'This course introduces the fundamental principles and practices for the design and implementation of compilers and interpreters. Core topics covered include: preprocessors, assemblers and linkers; scanning theory and practices; grammar and parsing; symbol tables; run-time environment and storage organization; lexical, syntax and semantic analysis; syntax directed translation and type checking; code generation and optimization; constructing prototype compiler modules for a hypothetical language', 
                '3',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE315',
				'Design of Operating System', 
				'This course serves as a rigorous introduction to the principles and practices of operating systems. Core concepts discussed are process model, process management, synchronization, threads, deadlocks, CPU scheduling, storage management, memory management, memory allocation, addressing, swapping, paging, segmentation, virtual memory organization, demand paging. More advanced OS topics covered:  file systems and their structure, access methods, interface, implementation and protection, I/O systems, mass-storage structures, system performance, networking, security and an overview of the structure, file system and coordination of distributed systems.', 
                '3',
                'CSE'
);


INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE316',
				'Data Communication and Computer Networks', 
				'A thorough examination of computer networks and the underlying data communication protocols. Topics covered are network categories and topologies, OSI model and TCP/IP protocol suite, TCP/IP applications, FTP, SMTP, HTTP and WWW,  transport layer protocols, link layer protocols, internetworking devices, repeaters, bridges and routers, routing algorithms, IP addressing, sub netting, domain name systems, network programming, LAN types and technology, MAC protocols, high speed LANs and Gigabit Ethernet, Wireless LANs, MAN, circuit switching and packet switching, ISDN, Frame Relay and ATM, SONET/SDH, spectrum and bandwidth, digital transmission, encoding, modulations and demodulations, multiplexing, interfaces and modems, transmission media, fiber optic and wireless media, error detection techniques.',
                '4',
                'CSE'
);

INSERT INTO course	(courseID, courseTitle, courseDescription, creditHour, deptID)
	VALUES	(	'CSE317',
				'Numerical Methods', 
				'An introduction to modern numerical approximation techniques. Topics include floating point computation, accuracy and errors, solutions of single variable equations, interpolation, polynomial approximation, numerical differentiation and integration, methods for solving single variable equations, systems of linear equations, first order differential equations and initial value problems. MATLAB will be used in the lab class to solve problem sets.',
                '3',
                'CSE'
);











select * from course;