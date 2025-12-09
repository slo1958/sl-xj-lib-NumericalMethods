#tag Module
Protected Module NumericalMethodSimplex
	#tag Method, Flags = &h0
		Sub test_simplex()
		  var cs as new clSimplex(4)
		  
		  cs.AddConstraint("C01", 1:"x1",2:"x3","<=":740)
		  cs.AddConstraint("C02", 2:"x2", -7:"x4","<=":0)
		  cs.AddConstraint("C03", 1:"x2", -1:"x3", 2:"x4", ">=":0.5)
		  cs.AddConstraint("C04",1:"x1",1:"x2",1:"x3",1:"x4",":":9)
		  
		  
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
		
		Solution is to replace, for example x2 by (xp2 - xm2)
		
		With
		
		   xp2 >=0
		   xm2 >=0
		
		2.x1 + 3.x2 - 1.x3 + 1.x4 becomes
		
		2.x1 + 3.(xp2-xm2) - 1.(xp3-xm3)  + 1.(xp4 - xm4) 
		
		
		
		
		2x1 + 3xp2 - 3xm2 - xp3 + xm3 + xp4 - xm4
		
		 
		
		
	#tag EndNote

	#tag Note, Name = Sources
		
		// This is based on 
		// - the routine SMPLEX in Numerical Recipes in Pascal: The Art of Scientific Computing
		// - on the document 'The Simplex Method' by Yinyu Ye, Department of Management Science and Engineering
		Stanford University
		
		
		
		
		Link: https://web.stanford.edu/class/msande310/lecture09.pdf
		
		
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
