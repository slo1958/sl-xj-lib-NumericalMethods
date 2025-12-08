#tag Module
Protected Module NumericalMethodsMatrixGeometry
	#tag Method, Flags = &h0
		Function columnMat(a() as Double) As double(,)
		  var b(-1,-1) as Double
		  
		  b.ResizeTo(a.LastIndex, 0)
		  
		  for i as integer = 0 to a.LastIndex
		    b(i,0) = a(i)
		    
		  next
		  
		  return b
		  
		End Function
	#tag EndMethod

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
		Sub MatAppendColumn(a(, ) as double, v() as double)
		  
		  var newColumnIndex as integer = a.LastIndex(2)+1
		  
		  a.ResizeTo(a.LastIndex(1), newColumnIndex)
		  
		  for i as integer = 0 to v.LastIndex
		    a(i, newColumnIndex) = v(i)
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MatAppendRow(a(, ) as double, v() as double)
		  
		  var newRowIndex as integer = a.LastIndex(1)+1
		  
		  a.ResizeTo(newRowIndex, a.LastIndex(2))
		  for i as integer = 0 to v.LastIndex
		    a(newRowIndex, i) = v(i)
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function rowMat(a() as Double) As double(,)
		  var b(-1,-1) as Double
		  
		  b.ResizeTo(0, a.LastIndex)
		  
		  for i as integer = 0 to a.LastIndex
		    b(0, i) = a(i)
		    
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
