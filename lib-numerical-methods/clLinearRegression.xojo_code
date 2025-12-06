#tag Class
Protected Class clLinearRegression
	#tag Method, Flags = &h0
		Function averageX() As double
		  Return self.maverageX
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function averageY() As double
		  Return self.maverageY
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Calc() As Boolean
		  
		  
		  var avg_x as double = self.averageX
		  var avg_y as Double = self.averageY
		  
		  var n as double
		  var d as double 
		  
		  self.mslope = 0
		  self.mintercept = 0
		  
		  var last_index as integer = self.sourceX.LastIndex
		  
		  if self.Count < 2 then return false
		  
		  if self.sourceX.LastIndex <> self.sourceY.LastIndex then return false
		  
		  for i as integer = 0 to last_index
		    var x_part as Double = (self.sourceX(i) - avg_x)
		    var y_part as Double = (self.sourceY(i) - avg_y)
		    
		    n = n + (x_part * y_part)
		    d = d + (x_part * x_part)
		    
		  next
		  
		  if abs(d) > 0.0001 then
		    self.mslope =  n/d
		    self.mintercept =  avg_y - self.mslope * avg_x
		    
		    return True
		  end if
		  
		  return false
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(x() as double, y() as double)
		  
		  self.sourceX.RemoveAll
		  self.sourceY.RemoveAll
		  
		  if x.LastIndex = y.LastIndex and x.Count > 0 then
		    
		    self.maverageX = 0
		    self.maverageY = 0
		    
		    for i as integer = 0 to x.LastIndex
		      self.maverageX = self.maverageX + x(i)
		      self.maverageY = self.maverageY + y(i)
		      
		      self.sourceX.Add(x(i))
		      self.sourceY.Add(y(i))
		      
		    next
		    
		    self.maverageX = self.maverageX / x.Count
		    self.maverageY = self.maverageY / y.Count
		    
		  end if
		  
		  self.mslope = 0
		  self.mintercept = 0
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As integer
		  return sourceX.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Evaluate(x() as double) As double()
		  
		  var res() as Double
		  
		  for each x1 as Double in x
		    res.Add(self.mslope*x1 + self.mIntercept)
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Intercept() As double
		  
		  return self.mintercept
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Slope() As Double
		  Return self.mslope
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private maverageX As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private maverageY As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mintercept As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mslope As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private sourceX() As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private sourceY() As Double
	#tag EndProperty


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
End Class
#tag EndClass
