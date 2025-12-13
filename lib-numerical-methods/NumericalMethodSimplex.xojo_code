#tag Module
Protected Module NumericalMethodSimplex
	#tag Method, Flags = &h0
		Sub test_simplex1(msgLog as itfMessageWriter)
		  //
		  // Create a system with 4 variables
		  //
		  var cs as new clSimplex(4)
		  
		  //
		  // Add constraints
		  //
		  cs.AddConstraint("C01", array(1:"x1",2:"x3"),"<=",740)  //  1.0 x X1 + 2.0 x X3 <= 740.0 
		  cs.AddConstraint("C02", array(2:"x2", -7:"x4"),"<=",0)
		  cs.AddConstraint("C03", array(1:"x2", -1:"x3", 2:"x4"), ">=",0.5)  // 1.0 x X2 -1.0 x X3 + 2.0 x X4 >= 0.5
		  cs.AddConstraint("C04",array(1:"x1",1:"x2",1:"x3",1:"x4"),"=",9)
		  
		  //
		  // Define objective function
		  //
		  cs.SetObjectiveFunction(clSimplex.Optimise.forMaximum, array(1:"x1",1:"x2",3:"x3", -0.5:"x4")) // max ( 1 x X1 + 1 x X2 + 3 x X3 - 0.5 x X4)
		  
		  cs.prepareMatrix
		  
		  //cs.DumpFullMatrixToLog
		  
		  cs.SolveProblem
		  
		  //cs.DumpSolutionToLog
		  
		  msgLog.WriteMessage(CurrentMethodName)
		  
		  msgLog.WriteMessage("Obj:"+cs.GetObjFunctionValue.ToString)
		  
		  var v() as Double = cs.GetSolution
		  var n as integer =1
		  for each d as double in v
		    msgLog.WriteMessage(  "x"+n.ToString + ":" + d.ToString)
		    n=n+1
		    
		  next
		  
		  msgLog.Done
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_simplex2(msgLog as itfMessageWriter)
		  //
		  // Create a system with 4 variables
		  //
		  var cs as new clSimplex(4)
		  
		  //
		  // Add constraints
		  //
		  cs.AddConstraint("C01", array(1.0, 0.0, 2.0, 0.0), "<=", 740)  //  1.0 x X1 + 2.0 x X3 <= 740.0
		  cs.AddConstraint("C02", array(0.0, 2.0, 0.0, -7.0), "<=", 0)
		  cs.AddConstraint("C03", array(0.0, 1.0,  -1.0, 2.0), ">=",0.5) // 1.0 x X2 -1.0 x X3 + 2.0 x X4 >= 0.5
		  cs.AddConstraint("C04",array(1:"x1",1:"x2",1:"x3",1:"x4"),"=",9)
		  
		  //
		  // Define objective function
		  //
		  cs.SetObjectiveFunction("max", array(1:"x1",1:"x2",3:"x3", -0.5:"x4")) // max ( 1 x X1 + 1 x X2 + 3 x X3 - 0.5 x X4)
		  
		  cs.prepareMatrix
		  
		  //cs.DumpFullMatrixToLog
		  
		  cs.SolveProblem
		  
		  //cs.
		  
		  msgLog.WriteMessage(CurrentMethodName)
		  
		  msgLog.WriteMessage("Obj:"+cs.GetObjFunctionValue.ToString)
		  
		  var v() as Double = cs.GetSolution
		  var n as integer =1
		  for each d as double in v
		    msgLog.WriteMessage(  "x"+n.ToString + ":" + d.ToString)
		    n=n+1
		    
		  next
		  
		  msgLog.Done
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_simplex3(msgLog as itfMessageWriter)
		  //
		  // Create a system with 4 variables
		  //
		  var cs as new clSimplex(4)
		  
		  //
		  // Add constraints
		  //
		  cs.AddConstraint("C01", array(1.0, 0.0, 2.0, 0.0, -1.0, 740.0)) //  1.0 x X1 + 2.0 x X3 <= 740.0
		  cs.AddConstraint("C02", array(0.0, 2.0, 0.0, -7.0, -1.0, 0.0))
		  cs.AddConstraint("C03", array(0.0, 1.0,  -1.0, 2.0, 1.0,0.5))  // 1.0 x X2 -1.0 x X3 + 2.0 x X4 >= 0.5
		  cs.AddConstraint("C04",array(1.0, 1.0 ,1.0, 1.0, 0, 9.0))
		  
		  //
		  // Define objective function
		  //
		  cs.SetObjectiveFunction(1, array(1.0, 1.0, 3.0, -0.5)) // max ( 1 x X1 + 1 x X2 + 3 x X3 - 0.5 x X4)
		  
		  cs.prepareMatrix
		  
		  //cs.DumpFullMatrixToLog
		  
		  cs.SolveProblem
		  
		  //cs.DumpSolutionToLog
		  
		  msgLog.WriteMessage(CurrentMethodName)
		  
		  msgLog.WriteMessage("Obj:"+cs.GetObjFunctionValue.ToString)
		  
		  var v() as Double = cs.GetSolution
		  var n as integer =1
		  for each d as double in v
		    msgLog.WriteMessage(  "x"+n.ToString + ":" + d.ToString)
		    n=n+1
		    
		  next
		  
		  msgLog.Done
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_simplex4(msgLog as itfMessageWriter)
		  //
		  // Create a system with 4 variables
		  //
		  var cs as new clSimplex(4)
		  
		  //
		  // Add constraints
		  //
		  cs.AddConstraint("C01", array(1.0:"x1"),"<=",2.0)  //  1.0 x X1 <= 2.0 
		  cs.AddConstraint("C02", array(1.0:"x2"),"<=",1.5) // 1.0 x X2 <= 1.5
		  cs.AddConstraint("C03", array(300.00:"x1",  1000.00:"x2",     10.00:"x3",  1500.00:"x4") ,">=",  2500.00)
		  cs.AddConstraint("C04", array(   20.0:"x1", 110.0:"x2", 10.0:"x3"),">=", 200.0)
		  cs.AddConstraint("C05", array(   15.0:"x1",    10.0:"x2",    8.0:"x3",    48.0:"x4"), ">=", 100.00)
		  
		   cs.SetObjectiveFunction(clSimplex.Optimise.forMinimum, array( 50.0:"x1", 80.0:"x2", 15.0:"x3", 180.0:"x4"))
		  
		  cs.prepareMatrix
		  
		  cs.DumpFullMatrix(true, true)
		  
		  
		  cs.SolveProblem
		  
		  cs.DumpSolutionToLog
		  
		  msgLog.WriteMessage(CurrentMethodName)
		  
		  msgLog.WriteMessage("Obj:"+cs.GetObjFunctionValue.ToString)
		  
		  var v() as Double = cs.GetSolution
		  var n as integer =1
		  for each d as double in v
		    msgLog.WriteMessage(  "x"+n.ToString + ":" + d.ToString)
		    n=n+1
		    
		  next
		  
		  msgLog.Done
		  
		  return
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Free variables
		
		 
		
		min  
		      2𝑥1+3𝑥2−𝑥3+𝑥4
		s.t. 
		     𝑥1+2𝑥2−𝑥3−5𝑥4=10 
		    −2𝑥1+3𝑥3−2𝑥4=5
		    𝑥1⩾0
		
		Here, x2, x3 and x4 are free variable
		
		Solution is to replace, for example x2 by (xp2 - xmat_isHigherOrEqual)
		
		With
		
		   xp2 >=0
		   xmat_isHigherOrEqual >=0
		
		2.x1 + 3.x2 - 1.x3 + 1.x4 becomes
		
		2.x1 + 3.(xp2-xmat_isHigherOrEqual) - 1.(xp3-xmat_isEqual)  + 1.(xp4 - xm4) 
		
		
		
		
		2x1 + 3xp2 - 3xmat_isHigherOrEqual - xp3 + xmat_isEqual + xp4 - xm4
		
		 
		
		
	#tag EndNote

	#tag Note, Name = Sources
		
		// This is based on 
		// - the routine SMPLEX in Numerical Recipes in Pascal: The Art of Scientific Computing
		// - on the document 'The Simplex Method' by Yinyu Ye, Department of Management Science and Engineering, Stanford University
		//
		
		
	#tag EndNote


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
