#tag Class
Class clSimplex
	#tag Method, Flags = &h0
		Sub AddConstraint(ConstraintID as string, terms() as pair, rel as string, rhs as double)
		  //
		  // 
		  //
		  // for the equation, terms:  constant:Xi, for example.  -x3 is written.  -1:"x2"
		  //
		  // rel is any of "<=", ">=", "="
		  //
		  
		  var vm() as double
		  var vrhs as double
		  var vForm as ConstraintForm
		  
		  var hasError as Boolean = false
		  
		  vm.ResizeTo(nbVariables-1)
		  
		  for each p as pair in terms
		    var v1 as variant = p.left
		    var v2 as variant = p.right
		    
		    if v1.IsNumeric then 
		      var v3 as integer =varToIndex(v2)
		      
		      if v3 < 0 then
		        self.AddError(ConstraintID + " invalid variable " + v2)
		        hasError = True
		        
		      elseif 0 <= v3-1 and v3-1 <= vm.LastIndex then
		        vm(v3-1)  = v1
		        
		      else
		        self.AddError(ConstraintID + " invalid variable " + v2)
		        hasError = True
		        
		      end if
		      
		    else
		      self.AddError(ConstraintID + "invalid value " + v1)
		      hasError = true
		      
		    end if
		    
		  next
		  
		  select case rel
		  case "<"
		    self.AddError(ConstraintID + " invalid relation "  + rel)
		    hasError = true
		    
		  case "<="
		    vForm = ConstraintForm.isLowerOrEqual
		    
		  case ">"
		    self.AddError(ConstraintID + " invalid relation "  + rel)
		    hasError = true
		    
		  case ">="
		    vForm= ConstraintForm.isHigherOrEqual
		    
		  case "="
		    vForm = ConstraintForm.isEqual
		    
		  case else
		    self.AddError(ConstraintID + " invalid relation "  + rel)
		    hasError = true
		    
		  end select
		  
		  vrhs = rhs 
		  
		  
		  if  hasError then
		    self.AddError(ConstraintID + " ignoring constraint")
		    
		  else
		    self.AddPreparedConstraint(vm, vrhs, vForm)
		    
		  end if
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddError(msg as string)
		  
		  self.Errors.Add(msg)
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddPreparedConstraint(cterms() as double, crhs as double, form as ConstraintForm)
		  
		  // Update constraints matrix
		  
		  select case form
		  case ConstraintForm.isLowerOrEqual
		    updateSelectedArray(mat_isLowerOrEqual, cterms, crhs)
		    
		  case ConstraintForm.isHigherOrEqual
		    updateSelectedArray(mat_isHigherOrEqual, cterms, crhs)
		    
		  case ConstraintForm.isEqual
		    updateSelectedArray(mat_isEqual, cterms, crhs)
		    
		  case else
		    
		    
		  end select
		  
		  // // Update slack column
		  // s.ResizeTo(idx)
		  // s(idx) = cslack
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(nbrVariables as integer)
		  self.nbVariables = nbrVariables
		  
		  self.runEndFlag = RunStatus.NotPrepared
		  
		  self.TraceRun = False
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DumpFullMatrixToLog()
		  const bigStr as string = "                                                      "
		  
		  var s as string
		  
		  
		  System.DebugLog("--FULL MATRIX --")
		  
		  s = right(bigStr, 10)
		  
		  for col as integer = 0 to mat_simplex.LastIndex(2)
		    s = s + right(bigStr + col.ToString, 10)
		    
		  next
		  System.DebugLog(s)
		  
		  for row as integer = 0 to mat_simplex.LastIndex(1)
		    
		    s = right(bigStr + row.tostring ,  10)
		    for col as integer = 0 to mat_simplex.LastIndex(2)
		      s = s + right(bigStr + format(mat_simplex(row,col),"###0.00"), 10)
		      
		    next
		    
		    System.DebugLog(s)
		    
		  next
		  
		  System.DebugLog("---")
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DumpMatrixToLog()
		  
		  
		  System.DebugLog("-- INPUT MATRIX --")
		  
		  for row as integer = 1 to nbConstraints
		    var s as  String
		    
		    s = "Constraint #" + row.ToString
		    
		    for col as integer = 1 to nbVariables
		      if abs(mat(row,col)) > 0.0001 then s = s + " " + mat(row,col).ToString("+##0.###") + " x X"+col.ToString 
		      
		    next
		    s = s + " " + relMark(row) + " " + mat(row, tcols2).ToString("+##0.###") 
		    
		    System.DebugLog(s)
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DumpSolutionToLog()
		  
		  
		  
		  var vminmax as double = minMaxFct
		  
		  // 
		  var basisp(-1) as integer
		  basisp = getBasisP
		  
		  
		  System.DebugLog("Value objective function " + format(-vminmax * mat(rowObjFctPhase2, tcols2), "-####0.000"))
		  
		  for col as integer  = 1 to nbVariables
		    var s as string
		    
		    s = col.ToString("00")+": "
		    
		    if basisp(col) = 0 then
		      s = s + Format(0.0, "-###0.000")
		      
		    else
		      s = s + format(mat(basisp(col), tcols2), "-###0.000")
		      
		    end if
		    
		    s = s + " red.costs"+ format(-vminmax*mat(rowObjFctPhase2, col),"-###0.000")
		    
		    System.DebugLog(s)
		    
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FindColumn(selectedRow as integer) As integer
		  
		  var q as Double = -cZero
		  var c as integer = -1
		  
		  for col as integer = 1 to tcols3
		    var v as Double = mat(selectedRow, col)
		    
		    if (v < q) then
		      c = col
		      q = v
		      
		    end if
		    
		  next
		  
		  if q = -cZero then 
		    self.runEndFlag = RunStatus.Done
		    
		  end if
		  
		  Return c
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getBasisP() As integer()
		  
		  var basisp(-1) as integer
		  
		  basisp.ResizeTo(nbVariables + nbConstraints)
		  
		  
		  
		  for col as integer = 1 to nbVariables + nbConstraints 
		    var row as integer
		    var f as Boolean = false
		    row = 1
		    do 
		      
		      if basis(row) = col then
		        f=true
		      else
		        row=row+1
		      end if
		      
		    loop until f or (row > nbConstraints)
		    
		    if f then
		      basisp(col) = row
		    else
		      basisp(col) = 0
		    end if
		    
		  next
		  
		  Return basisp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getErrors() As string()
		  
		  return self.Errors
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetObjFunctionValue() As Double
		  
		  if self.runEndFlag = RunStatus.Done then
		    return -minMaxFct() * mat(rowObjFctPhase2, tcols2)
		    
		  else
		    return 0
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetSolution() As double()
		  var r(-1) as double
		  var basisp(-1) as integer = getBasisP
		  
		  
		  r.ResizeTo(nbVariables-1)
		  
		  
		  for col as integer  = 1 to nbVariables
		    
		    
		    if basisp(col) = 0 then
		      r(col-1)  = 0
		      
		    else
		      r(col-1) = mat(basisp(col), tcols2)
		      
		    end if
		    
		  next
		  
		  return r
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Leave(useColumn as integer) As integer
		  
		  var q as Double = cMax
		  
		  var r as integer
		  
		  for row as integer = 1 to nbConstraints
		    var v as double = mat(row,useColumn)
		    
		    if v > cZero then
		      v = mat(row, tcols2) / v
		      if v < q then
		        r = row
		        q = v
		        
		      end if
		      
		    end if
		    
		  next
		  
		  if (q = cMax) then
		    AddError("Error in Leave")
		    self.runEndFlag = RunStatus.ErrorInLeave
		    
		  end if
		  
		  Return r
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mat(row as integer, col as integer) As double
		  
		  return mat_simplex(row,col)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mat(row as integer, col as integer, assigns v as double)
		  //
		  // Use a method so that we can easily add  breakpoint to trace updates
		  //
		  mat_simplex(row,col) = v
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub matResizeTo(maxrows as integer, maxcols as integer)
		  
		  mat_simplex.ResizeTo(maxrows, maxcols)
		  
		  for row as integer = 0 to maxrows
		    for col as Integer = 0 to maxcols
		      mat_simplex(row,col)= 0
		      
		    next
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function minMaxFct() As Double
		  
		  Return  if(self.runMode = Optimise.forMaximum ,-1.0,1.0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function nbConstraints() As integer
		  return mat_isLowerOrEqual.rowCount + mat_isHigherOrEqual.rowCount + mat_isEqual.rowCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Pivot(useRow as integer, useColumn as integer)
		  var value as double
		  var val as double
		  var vl as Double
		  
		  if TraceRun then System.DebugLog("Pivot " + useRow.ToString + " " + useColumn.ToString)
		  
		  value = mat(useRow, useColumn)
		  
		  for row as integer = 1 to rowObjFctPhase2
		    if (row <> useRow) then
		      vl = mat(row, useColumn)
		      
		      for col as integer = 1 to tcols2 
		        if (col <> useColumn) then
		          val = mat(row, col) - vl * mat(useRow, col) / value
		          if (abs(val) < czero) then
		            val = cZero
		          end if
		          mat(row, col) = val
		          
		        end if
		      next
		    end if
		  next
		  
		  for col as integer = 1 to tcols2
		    mat(useRow, col) = mat(useRow, col) / value
		    
		  next
		  
		  for row as integer = 1 to rowObjFctPhase2
		    mat(row, useColumn) = cZero
		    
		  next
		  
		  mat(useRow, useColumn) = 1.0
		  basis(useRow) = useColumn
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub prepareMatrix()
		  
		  var vminmax as double = minMaxFct
		  
		  basis.ResizeTo(nbConstraints)
		  
		  var nbrRows as integer = nbConstraints
		  
		  var nbrColumns as integer = nbVariables + nbConstraints + mat_isHigherOrEqual.rowCount() 
		  rowObjFctPhase1   = nbrRows + 1
		  rowObjFctPhase2  = nbrRows + 2
		  
		  tcols1 = nbVariables + nbConstraints +  mat_isHigherOrEqual.rowCount  
		  tcols2 = nbrColumns + 1
		  
		  // Start index of artifical variables
		  tcols3 = nbVariables + mat_isLowerOrEqual.rowCount + mat_isHigherOrEqual.rowCount 
		  
		  matResizeTo(nbrRows+2, nbrColumns+1)
		  
		  relMark.ResizeTo(nbrRows+2)
		  
		  RequiresPhase1 = false
		  
		  var rowIndex as integer = 1
		  
		  // RHS is duplicated in columns 0 and tcols2
		  for i as integer = 0 to mat_isLowerOrEqual.lastRowIndex 
		    for j as integer = 0 to nbVariables
		      mat(rowIndex, j) = mat_isLowerOrEqual(i, j)
		    next
		    mat(rowIndex, tcols2) = mat_isLowerOrEqual(i, 0)
		    
		    // add coef for slack variables
		    var tempcol as integer = nbVariables + rowIndex
		    
		    mat(rowindex, tempcol) = 1
		    
		    // add to base
		    basis(rowIndex ) = tempcol
		    
		    // Add rel mark
		    relMark(rowIndex) = "<="
		    
		    rowIndex = rowIndex + 1
		    
		  next
		  
		  for i as integer = 0 to mat_isEqual.lastRowIndex // (1)
		    for j as integer = 0 to nbVariables
		      mat(rowIndex, j) = mat_isEqual(i, j)
		      
		    next
		    mat(rowIndex, tcols2) = mat_isEqual(i, 0)
		    
		    // Add artificial variable in base
		    var tempcol as integer = rowIndex + nbVariables + mat_isHigherOrEqual.rowCount
		    mat(rowIndex , tempcol) = 1
		    basis(rowindex) = tempcol
		    
		    // Add rel mark
		    relMark(rowIndex) = "="
		    
		    // We need phase 1 because we added artificial variables
		    RequiresPhase1 = true
		    
		    rowIndex = rowIndex + 1
		    
		  next
		  
		  for i as integer = 0 to mat_isHigherOrEqual.lastRowIndex // (1)
		    for j as integer = 0 to nbVariables
		      mat(rowIndex, j) = mat_isHigherOrEqual(i, j)
		    next 
		    mat(rowIndex, tcols2) = mat_isHigherOrEqual(i, 0)
		    
		    // Add artificial variable in base
		    var tempcol as integer = rowIndex + nbVariables + mat_isHigherOrEqual.rowCount 
		    mat(rowIndex , tempcol) = 1
		    basis(rowindex) = tempcol
		    
		    // Add surplus variable
		    tempcol = nbVariables - mat_isEqual.rowCount + rowIndex
		    mat(rowIndex, tempcol) = -1
		    mat(rowObjFctPhase1, tempcol) = 1
		    
		    // Add rel mark
		    relMark(rowIndex) = ">="
		    
		    // We need phase 1 because we added artificial variables
		    RequiresPhase1 = true
		    
		    rowIndex = rowIndex + 1
		    
		  next
		  
		  // Move objective function
		  for j as integer = 1 to nbVariables
		    mat(0, j) = mat_objFunction(j-1) * vminmax
		    mat(rowObjFctPhase2,j )  = mat_objFunction(j-1) * vminmax
		    
		  next
		  
		  
		  // Calculate artificial variables
		  for col as integer = 1 to nbVariables
		    var v as Double=0
		    for row as integer = mat_isLowerOrEqual.RowCount+1 to nbConstraints
		      v = v - mat(row, col)
		    next
		    mat(rowObjFctPhase1, col) = v
		    
		  next
		  
		  self.runEndFlag = RunStatus.InProgress
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetObjectiveFunction(mode as optimise, terms() as pair)
		  
		  var hasError as Boolean = false
		  
		  mat_objFunction.ResizeTo(self.nbVariables-1)
		  
		  for each p as pair in terms
		    var v1 as variant = p.left
		    var v2 as variant = p.right
		    
		    if v1.IsNumeric then 
		      var v3 as integer =varToIndex(v2)
		      
		      if v3 < 0 then
		        self.AddError("Economic function, invalid variable " + v2)
		        hasError = True
		        
		      elseif 0 <= v3-1 and v3-1 <= mat_objFunction.LastIndex then
		        mat_objFunction(v3-1)  = v1
		        
		      else
		        self.AddError("Economic function, invalid variable " + v2)
		        hasError = True
		        
		      end if
		      
		    else
		      self.AddError("Economic function, invalid variable " + v2)
		      hasError = True
		      
		    end if
		    
		  next
		  
		  self.runMode = mode
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetObjectiveFunction(minMax as string, terms() as pair)
		  
		  select case minmax.Uppercase
		  case "MAX"
		    SetObjectiveFunction(clSimplex.Optimise.forMaximum, terms)
		    
		  case "MIN"
		    SetObjectiveFunction(clSimplex.Optimise.forMinimum, terms)
		    
		  case else
		    self.AddError("Invalid mode for SetObjectiveFunction, expected 'min' or 'max', found " + minMax)
		    
		  end select
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SimplexPhase(targetRow as integer)
		  
		  while self.runEndFlag = RunStatus.InProgress
		    var xcol as integer = FindColumn(targetRow)
		    var xrow as integer = -1
		    
		    if self.runEndFlag = RunStatus.InProgress then xrow = leave(xcol)
		    
		    if self.runEndFlag = RunStatus.InProgress then pivot(xrow, xcol)
		    
		  wend
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SolveProblem()
		  
		  if  self.runEndFlag <> RunStatus.InProgress then Return
		  
		  if RequiresPhase1 then
		    var col as integer
		    var f as Boolean
		    
		    SimplexPhase(rowObjFctPhase1)
		    
		    self.runEndFlag = RunStatus.ErrorPostProcPhase1
		    
		    for row as integer = 1 to nbConstraints
		      
		      if basis(row) > tcols3 then
		        
		        if mat(row, tcols2) > cZero  then Return
		        
		        f = true
		        col = 1
		        while f and col <= tcols3
		          if abs(mat(row,col)) > cZero then
		            pivot(row, col)
		            f = false
		          end if
		          
		          col = col + 1
		          
		        Wend
		        
		      end if
		    next
		    
		  end if
		  
		  self.runEndFlag = RunStatus.InProgress 
		  SimplexPhase(rowObjFctPhase2)
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Untitled()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Untitled1()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub updateSelectedArray(m(, ) as Double, cterms() as double, rhs as double)
		  // Add a new row
		  var idx as integer = m.lastRowIndex+1
		  
		  m.ResizeTo(idx, nbVariables) // This provides nbColumns + 1 columns
		  
		  m(idx,0) = rhs
		  
		  // move terms
		  for i as integer = 0 to nbVariables-1
		    m(idx, i+1) = cterms(i)
		    
		  next
		  
		  Return 
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function varToIndex(varname as string) As integer
		  
		  if varname.left(1) <> "x" then Return -1
		  
		  var tmp as string = varname.right(varname.Length-1).trim
		  
		  if IsNumeric(tmp) then
		    return tmp.ToInteger
		    
		  else
		    return -1
		    
		  end if
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private basis(-1) As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Errors() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			Initial storage for constraint with '=' sign
		#tag EndNote
		Private mat_isEqual(-1,-1) As double
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			Initial storage for constraint with '>=' sign
		#tag EndNote
		Private mat_isHigherOrEqual(-1,-1) As double
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			Initial storage for constraint with '<=' sign
		#tag EndNote
		Private mat_isLowerOrEqual(-1,-1) As double
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			Initial storage objective function
		#tag EndNote
		Private mat_objFunction() As double
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			main matrix used by Solver
		#tag EndNote
		Private mat_simplex(-1,-1) As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private nbVariables As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			stores '<=', '=' or '>=' for each constraint moved to the main simplex matrix
		#tag EndNote
		Private relMark() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private RequiresPhase1 As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private rowObjFctPhase1 As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private rowObjFctPhase2 As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private runEndFlag As RunStatus
	#tag EndProperty

	#tag Property, Flags = &h21
		Private runMode As optimise
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tcols1 As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			ColRHS
		#tag EndNote
		Private tcols2 As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			ColRHS
		#tag EndNote
		Private tcols3 As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private TraceRun As Boolean
	#tag EndProperty


	#tag Constant, Name = cMax, Type = Double, Dynamic = False, Default = \"10.0e+35", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cZero, Type = Double, Dynamic = False, Default = \"0.0000001", Scope = Public
	#tag EndConstant


	#tag Enum, Name = ConstraintForm, Type = Integer, Flags = &h0
		isLowerOrEqual
		  isHigherOrEqual
		isEqual
	#tag EndEnum

	#tag Enum, Name = Optimise, Type = Integer, Flags = &h0
		forMinimum
		forMaximum
	#tag EndEnum

	#tag Enum, Name = RunStatus, Type = Integer, Flags = &h0
		InProgress
		  Done
		  ErrorInLeave
		  NotPrepared
		ErrorPostProcPhase1
	#tag EndEnum


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
