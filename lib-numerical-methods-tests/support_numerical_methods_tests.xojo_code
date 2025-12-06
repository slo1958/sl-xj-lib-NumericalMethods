#tag Module
Protected Module support_numerical_methods_tests
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
		Sub TestMatAdd()
		  
		  var a(3,2) as Double
		  
		  SetArrayRow(a, 0, Array(1.0, 3.0))
		  SetArrayRow(a, 1, Array(1.0, 0.0))
		  SetArrayRow(a, 2, Array(1.0, 2.0))
		  
		  var b(3,2) as Double
		  
		  SetArrayRow(b, 0, Array(0.0, 0.0))
		  SetArrayRow(b, 1, Array(7.0, 5.0))
		  SetArrayRow(b, 2, Array(2.0, 1.0))
		  
		  
		  var c(-1,-1) as Double = MatAdd(a,b)
		  
		  var x(3,2) as Double
		  SetArrayRow(x, 0, array(1.0, 3.0))
		  SetArrayRow(x, 1, array(8.0, 5.0))
		  SetArrayRow(x, 2, array(3.0, 3.0))
		  
		  call check_matrix("Mat addition", c,x )
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMatIdentifty()
		  
		  var a(2,2) as Double
		  
		  SetArrayRow(a, 0, Array(1.0, 0.0,  3.0))
		  SetArrayRow(a, 1, Array(1.0, 0.0, 0.0))
		  SetArrayRow(a, 2, Array(1.0, 0.0, 2.0))
		  
		  var x(2,2) as Double
		  
		  SetArrayRow(x, 0, Array(1.0, 0.0, 0.0))
		  SetArrayRow(x, 1, Array(0.0, 1.0, 0.0))
		  SetArrayRow(x, 2, Array(0.0, 0.0, 1.0))
		  
		  MatIdentity(a)
		  
		  Call check_matrix("Identity", a, x)
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMatMult()
		  
		  //
		  // Example taken from https://en.wikipedia.org/wiki/Matrix_multiplication
		  //
		  var a(3,2) as double
		  
		  SetArrayRow(a, 0, array(1.0, 0.0, 1.0))
		  SetArrayRow(a, 1, array(2.0, 1.0, 1.0))
		  SetArrayRow(a, 2, array(0.0, 1.0, 1.0))
		  SetArrayRow(a, 3, array(1.0, 1.0, 2.0))
		  
		  
		  var b(-1, -1) as double
		  SetArrayRow(b, 0, array(1.0, 2.0, 1.0))
		  SetArrayRow(b, 1, array(2.0, 3.0, 1.0))
		  SetArrayRow(b, 2, array(4.0, 2.0, 2.0))
		  
		  
		  var ab(-1,-1) as double = MatMult(a, b)
		  
		  var x() as double = array(100.0, 80.0, 60.0)
		  
		  var abx() as Double = MatMult(ab, x)
		  
		  var abexpected(-1,-1) as double 
		  SetArrayRow(abexpected, 0, array(5.0, 4.0, 3.0))
		  SetArrayRow(abexpected, 1, array(8.0, 9.0, 5.0))
		  SetArrayRow(abexpected, 2, array(6.0, 5.0, 3.0))
		  SetArrayRow(abexpected, 3, array(11.0, 9.0, 6.0))
		  
		  var abxexpected() as Double = array(1000.0, 1820.0, 1180.0, 2180.0)
		  
		  call check_matrix("Matrix x matrix " , ab, abexpected)
		  call check_matrix("Matrix x vector " , mat(abx), mat(abxexpected))
		  
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSlopAndIntercept()
		  
		  
		  var x() as Double
		  var y() as Double
		  
		  x = array(6.0, 5.0, 11.0, 7.0, 5.0 ,4. , 4.0)
		  y = array(2.0,3.0,9.0,1.0,8.0,7.0,5.0)
		  
		  
		  var expected_s as double = 0.3055555555555556
		  var expected_i as double = 3.1666666666666665
		  
		  
		  var s as Double = slope(x,y)
		  var i as Double = intercept(x,y)
		  
		  if abs(s - expected_s) > 0.001 then System.DebugLog("Error in slope")
		  if abs(i - expected_i) > 0.001 then System.DebugLog("Error in intercept")
		  
		  return
		  
		End Sub
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
