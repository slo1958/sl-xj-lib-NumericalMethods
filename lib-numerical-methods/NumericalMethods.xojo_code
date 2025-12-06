#tag Module
Protected Module NumericalMethods
	#tag Method, Flags = &h0
		Function Intercept(x() as double, y() as double) As double
		  
		  
		  var avg_x as double = sampleMean(x)
		  var avg_y as Double = sampleMean(y)
		  
		  return avg_y - slope(x,y) * avg_x
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function sampleMean(v() as double) As double
		  //
		  // Calculate sample mean
		  //
		  var r as double
		  var c as Double
		  r = v(0)
		  c = 1
		  for i as integer = 1 to v.LastIndex
		    r = r + v(i)
		    c = c + 1
		    
		  next
		  
		  return r/c
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Slope(x() as double, y() as double) As double
		  
		  
		  //
		  // Equation for slope is given by 
		  //.   n =sum ( (x-avg(x) ) . (y-avg(y) )
		  //.  d = sum ( (x-avg(x)) ^2
		  //  results given by n / d
		  //
		  
		  
		  var avg_x as double = sampleMean(x)
		  var avg_y as Double = sampleMean(y)
		  
		  var n as double
		  var d as double 
		  
		  var last_index as integer = x.LastIndex
		  
		  if x.LastIndex <> y.LastIndex then return 0
		  
		  for i as integer = 0 to last_index
		    var x_part as Double = (x(i) - avg_x)
		    var y_part as Double = (y(i) - avg_y)
		    
		    n = n + (x_part * y_part)
		    d = d + (x_part * x_part)
		    
		  next
		  
		  if abs(d) > 0.0001 then
		    return n/d
		    
		  else
		    return 0
		    
		  end if
		  
		End Function
	#tag EndMethod


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
