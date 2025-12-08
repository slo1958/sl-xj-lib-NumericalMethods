#tag Module
Protected Module NumericalMethodMatrixLUDecomposition
	#tag Method, Flags = &h0
		Function LUBackSubstitution(d(, ) as double, index() as integer, b() as Double, x() as double) As integer
		  //
		  // Back substituion
		  //
		  // Parameters
		  // - d(, ) the LU decomposed matrix produced by LUDecomposition
		  // - index() is permutation vector returned by LUDecomposition
		  // - b() right hand side vector,
		  // - x() will contain the results
		  //
		  // Returns
		  //  calculation status (0 for ok)
		  //
		  // This is based on 
		  // - the routine LUBKSB in Numerical Recipes in Pascal: The Art of Scientific Computing
		  // - the article Numerical Methods in Physics (515.421) by Prof Heinrich Sormann
		  //
		  
		  
		  if not MatisSquare(d) then Return -1
		  if d.LastIndex(1) <> b.LastIndex then return -2
		  if d.LastIndex(1) <> index.LastIndex then return -3
		  
		  var n as integer = d.LastIndex(1)
		  
		  var work(-1) as double
		  var bcopy(-1) as Double
		  
		  bcopy.ResizeTo(n)
		  x.ResizeTo(n)
		  work.ResizeTo(n)
		  
		  // Preserve B
		  for i as Integer = 0 to b.LastIndex
		    bcopy(i) = b(i)
		  next
		  
		   
		  var sum as double
		  
		  for i as integer = 0 to n
		    var tmp_idx as integer = index(i)
		    sum = bcopy(tmp_idx)
		    bcopy(tmp_idx) = bcopy(i)
		    
		    for j as integer = 0 to i-1
		      sum = sum - d(i,j) * work(j)
		    next
		    
		    work(i) = sum
		    
		  next
		  
		  
		  for i as integer = n to 0 step -1
		    sum = work(i)
		    
		    if (i < n) then
		      for j as integer = i+1 to n
		        sum = sum - d(i,j)*x(j)
		      next
		    end if
		    
		    x(i) = sum / d(i,i)
		    
		  next
		  
		  return 0
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LUDecomposition(a(, ) as double, index() as integer) As integer
		  //
		  // Performs LU Decomposition
		  //
		  // - a(,) source matrix
		  // - index() vector recording the row permutations
		  // - d indicates the number of permutations are odd or even
		  //
		  // Returns
		  //  calculation status (0 for ok)
		  //
		  // This is based on 
		  // - the routine LUDCMP in Numerical Recipes in Pascal: The Art of Scientific Computing
		  //
		  var vv(-1) as Double
		  
		  if not MatisSquare(a) then return -1
		  
		  var n as integer = a.LastIndex(1)
		  var d as integer = 1
		  
		  vv.ResizeTo(n)
		  index.ResizeTo(n)
		  
		  var imax as integer
		  var aamax as Double
		  var sum as Double
		  var dum as Double
		  
		  for i as integer = 0 to n
		    aamax=0
		    for j as integer = 0 to n
		      if abs(a(i,j)) > aamax then aamax = abs(a(i,j))
		    next
		    
		    if (aamax=0) then
		      return -2
		      
		    end if
		    
		    vv(i) = 1 / aamax
		    
		  next
		  
		  for j as integer = 0 to n
		    for i as integer = 1 to j-1
		      sum  = a(i,j)
		      for k as integer = 0 to i-1
		        sum = sum - a(i,k)*a(k,j)
		      next
		      a(i,j) = sum
		    next
		    
		    aamax = 0
		    for i as integer = j to n
		      sum = a(i,j)
		      for k as integer = 0 to j-1
		        sum = sum -a(i,k)*a(k,j)
		      next
		      a(i,j) = sum
		      
		      dum = vv(i) * abs(sum)
		      if dum >= aamax then
		        imax = i
		        aamax = dum
		      end if
		      
		    next
		    
		    if j <> imax then
		      for k as integer = 0 to n
		        dum = a(imax, k)
		        a(imax,k) = a(j,k)
		        a(j,k) = dum
		      next
		      d=-d
		      vv(imax) = vv(j)
		    end if
		    
		    
		    index(j) = imax
		    
		    if a(j,j) = 0 then a(j,j) = 0.00001
		    
		    if j <> n then
		      dum = 1.0 / a(j,j)
		      for  i as integer = j+1 to n
		        a(i,j) = a(i,j) * dum
		      next
		    end if
		    
		  next
		  
		  return 0
		  
		  
		  
		  
		  
		  
		  
		  
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
