#tag Module
Protected Module NumericalMethodsMatrix
	#tag Method, Flags = &h0
		Function CrossProduct(a() as double, b() as double) As double()
		  //
		  // Source : https://en.wikipedia.org/wiki/Cross_product
		  //
		  var r(-1) as double 
		  
		  if  a.LastIndex() <>  b.LastIndex() or a.LastIndex() <> 2 then return r
		  
		  r.ResizeTo(2)
		  
		  r(0) = a(1) * b(2) - a(2)- b(1)
		  r(1) = a(2)*b(0) - a(0)*b(2)
		  r(2) = a(0) * b(1) - a(1)*b(0)
		  
		  return r
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DotProduct(a() as double, b() as double) As double
		  
		  var r as double = 0
		  
		  if  a.LastIndex(1) <>  b.LastIndex(1) then return r
		  
		  for i as integer = 0 to a.LastIndex(1)
		    r = r + a(i) * b(i) 
		    
		  next
		  
		  return r
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatAdd(a(, ) as double, b(, ) as double) As double(,)
		  var res(-1,-1) as Double
		  
		  if not MatSameSize(a,b) then return res
		  
		  res.ResizeTo(a.LastIndex(1), a.LastIndex(2))
		  
		  
		  for i as integer = 0 to a.LastIndex(1) 
		    for j as integer = 0 to a.LastIndex(2)
		      res(i,j) = a(i,j) + b(i,j)
		      
		    next
		  next
		  
		  return res
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatCopy(a(, ) as Double) As double(,)
		  var r(-1,-1) as Double
		  
		  r.ResizeTo(a.LastIndex(1), a.LastIndex(2))
		  
		  for i as integer = 0 to a.LastIndex(1)
		    for j as integer =0 to a.LastIndex(2)
		      r(i,j) = a(i,j)
		    next
		    
		  next
		  
		  return r
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatCopy(a() as Double) As double()
		  
		  var r(-1) as Double
		  
		  r.ResizeTo(a.LastIndex)
		  
		  for i as integer = 0 to a.LastIndex
		    r(i) = a(i)
		    
		  next
		  
		  return r
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MatDebugLog(a(, ) as Double, dblFormat as string = "-#####.000")
		  
		  System.DebugLog("Dump matrix (" + a.LastIndex(1).ToString + "," + a.LastIndex(2).ToString+")")
		  
		  for i as integer = 0 to a.LastIndex(1)
		    var s as string
		    s = "Row " + Format(i, "000") + ":"
		    for j as integer = 0 to a.LastIndex(2)
		      s = s + Format(a(i,j), dblFormat) + " " 
		    next
		    
		    System.DebugLog(s)
		    
		  next
		  
		  System.DebugLog(" ")
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MatDebugLog(a() as Double, dblFormat as string = "-#####.000")
		  
		  System.DebugLog("Dump matrix (" + a.LastIndex(1).ToString  +")")
		  
		  for i as integer = 0 to a.LastIndex(1)
		    var s as string
		    s = "Row " + Format(i, "000") + ":"+ Format(a(i), dblFormat)
		    
		    System.DebugLog(s)
		    
		  next
		  
		  System.DebugLog(" ")
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MatIdentity(a(, ) as double)
		  var aRowIndex as integer = a.LastIndex(1)
		  var aColIndex as integer = a.LastIndex(2)
		  
		  
		  if aRowIndex <> aColIndex then return
		  
		  for i as integer = 0 to aRowIndex 
		    for j as integer = 0 to aColIndex
		      a(i,j) = if(i=j,1,0)
		      
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatIsSquare(a(, ) as Double) As Boolean
		  //
		  // Returns true if the matrix is squared
		  //
		  
		  return a.LastIndex(1) = a.LastIndex(2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatMult(a(, ) as double, b(, ) as double) As double(,)
		  //
		  // Calculates the product of the matrix a(m x n) with the matrix b(n x p)
		  // 
		  // returns a matrix(m x p)
		  //
		  
		  var r(-1,-1) as double
		  
		  var aRowIndex as integer = a.LastIndex(1)
		  var aColIndex as integer = a.LastIndex(2)
		  
		  var bRowIndex as integer = b.LastIndex(1)
		  var bColIndex as integer = b.LastIndex(2)
		  
		  if (aColIndex <> bRowIndex) then return r
		  
		  r.ResizeTo(aRowIndex,bColIndex)
		  
		  var v as integer = 1
		  
		  for outputRowIndex as integer = 0 to aRowIndex
		    
		    for outputColumnIndex as integer = 0 to bColIndex
		      var s as double = 0
		      
		      for innerIndex as integer = 0 to aColIndex
		        s = s + a(outputRowIndex, innerIndex) * b(innerIndex, outputColumnIndex)
		        
		      next
		      
		      r(outputRowIndex, outputColumnIndex) = s
		      
		    next
		  next
		  
		  return r
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatMult(a(, ) as double, x() as double) As double()
		  //
		  // Calculates the product of the matrix a(m x n) with the vector x(n)
		  // 
		  // returns a vector(m)
		  //
		  
		  var r(-1) as double
		  
		  var aRowIndex as integer = a.LastIndex(1)
		  var aColIndex as integer = a.LastIndex(2)
		  
		  var xIndex as integer = x.LastIndex(1)
		  
		  if (aColIndex <> xIndex) then return r
		  
		  // ResizeTo expects the last index, not the size :)
		  r.ResizeTo(aRowIndex)
		  
		  
		  for outputIndex as integer = 0 to aRowIndex
		    
		    var s as double =  a(outputIndex, 0) * x(0)
		    
		    for innerIndex as integer = 1 to aColIndex
		      s = s + a(outputIndex, innerIndex) * x(innerIndex)
		      
		    next
		    
		    r(outputIndex) = s
		    
		  next
		  
		  return r
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatMult(a(, ) as double, c as double) As double(,)
		  //
		  // Calculates the product of the matrix a(n x p ) with scalar c
		  // 
		  // returns a matrix(n x p)
		  //
		  
		  var r(-1,-1) as double
		  
		  var aRowIndex as integer = a.LastIndex(1)
		  var aColIndex as integer = a.LastIndex(2)
		  
		  
		  
		  for i as integer = 0 to aRowIndex
		    for j as integer= 0 to aColIndex
		      r(i,j) = c * a(i,j)
		      
		    next
		    
		  next
		  
		  return r
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatMult(x() as double, a(, ) as double) As double()
		  //
		  // Calculates the product of the vector(n) with matrix a(n x p) 
		  // 
		  // returns a vector(p)
		  //
		  var r(-1) as double
		  
		  var xIndex as integer = x.LastIndex(1)
		  
		  var aRowIndex as integer = a.LastIndex(1)
		  var aColIndex as integer = a.LastIndex(2)
		  
		  if (xIndex <> aRowIndex) then return r
		  
		  r.ResizeTo(aColIndex)
		  
		  for outputIndex as integer = 0 to aColIndex 
		    var s as double =  x(0) * a(0, outputIndex)  
		    
		    for innerIndex as integer = 1 to aColIndex
		      s = s + x(innerindex) * a(innerIndex, outputIndex)  
		      
		    next
		    
		    r(outputIndex) = s
		    
		    
		  next
		  
		  return r
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatMult(a() as double, b() as double) As double
		  //
		  // Calculates the product of the vector a(n) with the vector b(n)
		  // 
		  // returns a double
		  //
		  
		  return DotProduct(a,b)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatMult(a() as double, c as double) As double()
		  //
		  // Calculates the product of the matrix a(n x p ) with scalar c
		  // 
		  // returns a matrix(n x p)
		  //
		  
		  var r(-1) as double
		  
		  var aIndex as integer = a.LastIndex(1)
		  
		  r.ResizeTo(aIndex)
		  
		  for i as integer = 0 to aIndex
		    r(i) = a(i) * c 
		    
		  next
		  
		  return r
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatSameSize(a(, ) as double, b(, ) as double) As Boolean
		  
		  return a.LastIndex(1) = b.LastIndex(1) and a.LastIndex(2) = b.LastIndex(2)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OuterProduct(a() as double, b() as double) As double(,)
		  //
		  // Calculates the outer product of vector a(m) x vector b(n)
		  //
		  // Returns matrix(m x n)
		  //
		  
		  var r(-1,-1) as double 
		  
		  var rowIndex as integer = a.LastIndex
		  var colindex as integer = b.LastIndex
		  
		  r.ResizeTo(rowIndex, colindex)
		  
		  for i as integer = 0 to rowIndex
		    for j as integer = 0 to colindex
		      r(i,j) = a(i) * b(j)
		      
		    next
		  next
		  
		  return r
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetArrayRow(a(, ) as double, rowindex as integer, r() as double)
		  //
		  // Add a row and adjust size
		  //
		  
		  var newRowSize as integer = a.LastIndex(1)
		  var newColSize as integer = a.LastIndex(2)
		  
		  if newRowSize < RowIndex then newRowSize = RowIndex
		  if newColSize < r.LastIndex then newColSize = r.LastIndex
		  
		  a.ResizeTo(newRowSize, newColSize)
		  
		  for i as integer = 0 to r.LastIndex
		    a(RowIndex, i) = r(i)
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transpose(a(, ) as double) As double(,)
		  
		  //
		  // Transpose the array
		  //
		  
		  var RowIndex as integer = a.LastIndex(1)
		  var ColIndex as integer = a.LastIndex(2)
		  
		  
		  var r(-1,-1) as Double
		  
		  r.ResizeTo(ColIndex, RowIndex)
		  
		  for i as integer = 0 to RowIndex
		    for j as integer = 0 to ColIndex
		      r(j,i) = a(i,j)
		      
		    next
		  next
		  
		  return r
		  
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
