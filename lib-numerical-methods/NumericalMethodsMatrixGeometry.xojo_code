#tag Module
Protected Module NumericalMethodsMatrixGeometry
	#tag Method, Flags = &h0
		Function columnVect(a(, ) as double, columnIndex as integer) As double()
		  var v(-1) as double
		  
		  v.ResizeTo(a.LastIndex(2))
		  
		  for i as integer = 0 to a.LastIndex(1)
		    v(i) = a(i, columnIndex)
		    
		  next
		  
		  return v
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function mat(a() as Double) As double(,)
		  var b(-1,-1) as Double
		  
		  b.ResizeTo(a.LastIndex, 0)
		  
		  for i as integer = 0 to a.LastIndex
		    b(i,0) = a(i)
		    
		  next
		  
		  return b
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function rowVect(a(, ) as double, RowIndex as integer) As double()
		  var v(-1) as double
		  
		  v.ResizeTo(a.LastIndex(1))
		  
		  for i as integer = 0 to a.LastIndex(2)
		    v(i) = a(RowIndex, i)
		    
		  next
		  
		  return v
		  
		  
		End Function
	#tag EndMethod


End Module
#tag EndModule
