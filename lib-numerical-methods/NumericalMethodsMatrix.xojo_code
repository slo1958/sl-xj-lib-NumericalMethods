#tag Module
Protected Module NumericalMethodsMatrix
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
		Sub MatIdentity(a(, ) as double)
		  var arowindex as integer = a.LastIndex(1)
		  var acolindex as integer = a.LastIndex(2)
		  
		  
		  if arowindex <> acolindex then return
		  
		  for i as integer = 0 to arowindex 
		    for j as integer = 0 to acolindex
		      a(i,j) = if(i=j,1,0)
		      
		    next
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatMult(a(, ) as double, b(, ) as double) As double(,)
		  
		  var r(-1,-1) as double
		  
		  var arowindex as integer = a.LastIndex(1)
		  var acolindex as integer = a.LastIndex(2)
		  
		  var browindex as integer = b.LastIndex(1)
		  var bcolindex as integer = b.LastIndex(2)
		  
		  if (acolindex <> browindex) then return r
		  
		  r.ResizeTo(arowindex,bcolindex)
		  
		  var v as integer = 1
		  
		  for outputRowIndex as integer = 0 to arowindex
		    
		    for outputColumnIndex as integer = 0 to bcolindex
		      var s as double = 0
		      
		      for innerIndex as integer = 0 to acolindex
		        s = s + a(outputRowIndex, innerIndex) * b(innerIndex, outputColumnIndex)
		        
		      next
		      
		      r(outputRowIndex, outputColumnIndex) = s
		      
		    next
		  next
		  
		  return r
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MatMult(a(, ) as double, b() as double) As double()
		  
		  var r(-1) as double
		  
		  var arowindex as integer = a.LastIndex(1)
		  var acolindex as integer = a.LastIndex(2)
		  
		  var browindex as integer = b.LastIndex(1)
		  var bcolindex as integer = 0
		  
		  if (acolindex <> browindex) then return r
		  
		  // ResizeTo expects the last index, not the size :)
		  r.ResizeTo(arowindex)
		  
		  var v as integer = 1
		  
		  for outputRowIndex as integer = 0 to arowindex
		    
		    var s as double = 0
		    
		    for innerIndex as integer = 0 to acolindex
		      s = s + a(outputRowIndex, innerIndex) * b(innerIndex)
		      
		    next
		    
		    r(outputRowIndex) = s
		    
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
		Sub SetArrayRow(a(, ) as double, rowindex as integer, r() as double)
		  //
		  // Add a row and adjust size
		  //
		  
		  var newRowSize as integer = a.LastIndex(1)
		  var newColSize as integer = a.LastIndex(2)
		  
		  if newRowSize < rowindex then newRowSize = rowindex
		  if newColSize < r.LastIndex then newColSize = r.LastIndex
		  
		  a.ResizeTo(newRowSize, newColSize)
		  
		  for i as integer = 0 to r.LastIndex
		    a(rowindex, i) = r(i)
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transpose(a(, ) as double) As double(,)
		  
		  //
		  // Transpose the array
		  //
		  
		  var rowIndex as integer = a.LastIndex(1)
		  var colIndex as integer = a.LastIndex(2)
		  
		  
		  var r(-1,-1) as Double
		  
		  r.ResizeTo(colIndex, rowIndex)
		  
		  for i as integer = 0 to rowIndex
		    for j as integer = 0 to colIndex
		      r(j,i) = a(i,j)
		      
		    next
		  next
		  
		  return r
		  
		End Function
	#tag EndMethod


End Module
#tag EndModule
