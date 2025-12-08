#tag Module
Protected Module NumericalMethodMatrixHelpers
	#tag Method, Flags = &h0
		Function check_matrix(msg as string, calculated(, ) as double, expected(, ) as double) As Boolean
		  
		  var ccRowIndex as integer = calculated.LastIndex(1)
		  var ccColIndex as integer = calculated.LastIndex(2)
		  
		  var exRowIndex as integer = expected.LastIndex(1)
		  var exColIndex as integer = expected.LastIndex(2)
		  
		  System.DebugLog("Start checking " + msg)
		  
		  if not MatSameSize(calculated, expected) then
		    
		    System.DebugLog(msg + " array size(" + str(ccRowIndex) + "," + str(ccColIndex)+ ") not matching expected size (" + str(exRowIndex) + "," + str(exColIndex)+ ")")
		    return false
		    
		  end if
		  
		  var b as Boolean = true
		  
		  for r as integer = 0 to ccRowIndex
		    for c as integer = 0 to ccColIndex
		      if abs(calculated(r,c) - expected(r,c)) < 0.001 then 
		        
		        
		      else
		        System.DebugLog("Calculated value at (" + str(r) + "," + str(c)+ ")  "  _
		        + calculated(r,c).ToString _
		        + " not matching expected value " _
		        + expected(r,c).ToString)
		        
		        b = false
		        
		        
		      end if
		      
		    next
		  next
		  
		  System.DebugLog("Done checking " + msg)
		  
		  
		  return b
		  
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
		Function MatIsSquare(a(, ) as Double) As Boolean
		  //
		  // Returns true if the matrix is squared
		  //
		  
		  return a.LastIndex(1) = a.LastIndex(2)
		  
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
		  
		  if newRowSize < RowIndex then newRowSize = RowIndex
		  if newColSize < r.LastIndex then newColSize = r.LastIndex
		  
		  a.ResizeTo(newRowSize, newColSize)
		  
		  for i as integer = 0 to r.LastIndex
		    a(RowIndex, i) = r(i)
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod


End Module
#tag EndModule
