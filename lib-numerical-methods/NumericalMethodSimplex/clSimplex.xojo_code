#tag Class
Class clSimplex
	#tag Method, Flags = &h0
		Sub AddConstraint(ConstraintID as string, paramarray term as pair)
		  //
		  // Constaint term
		  //
		  // for the equation:   constant:Xi, for example.  -x3 is written.  -1:"x2"
		  // for the rhs: relation:constant , for example. <=0 is written "<=":0
		  //
		  
		  var vm() as double
		  var vs as double
		  var vrhs as double
		  
		  var hasError as Boolean = false
		  
		  vm.ResizeTo(nbColumns)
		  
		  for each p as pair in term
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
		      select case v1
		      case "<"
		        self.AddError(ConstraintID + " invalid relation "  + v1)
		        hasError = true
		        
		      case "<="
		        vs = 1
		      case ">"
		        self.AddError(ConstraintID + " invalid relation "  + v1)
		        hasError = true
		        
		      case ">="
		        vs = -1
		        
		      case "="
		        vs = 0
		        
		      case else
		        self.AddError(ConstraintID + " invalid relation "  + v1)
		        hasError = true
		        
		      end select
		      
		      vrhs = v2.DoubleValue
		      
		      // handling rhs
		      
		    end if
		    
		  next
		  
		  if  hasError then
		    self.AddError(ConstraintID + " ignoring constraint")
		    
		  else
		    self.AddPreparedConstraint(vm, vs, vrhs)
		    
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
		Private Sub AddPreparedConstraint(cterms() as double, cslack as double, crhs as double)
		  
		  // Add a new row
		  var idx as integer = m.LastIndex(1)+1
		  m.ResizeTo(idx, nbColumns)
		  
		  // move terms
		  for i as integer = 0 to cterms.LastIndex
		    m(idx, i) = cterms(i)
		    
		  next
		  
		  // Update slack column
		  s.ResizeTo(idx)
		  s(idx) = cslack
		  
		  // Update rhs column
		  rhs.ResizeTo(idx)
		  rhs(idx) = crhs
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddUpperBound(variable as string, bound as Double)
		  
		  var hasError as Boolean = false
		  var vm() as double
		  vm.ResizeTo(nbColumns)
		  
		  var v3 as integer = varToIndex(variable)
		  
		  if v3 < 0 then
		    self.AddError("Upper bound for " + variable+ " invalid variable")
		    hasError = True
		    
		  elseif 0 <= v3-1 and v3-1 <= vm.LastIndex then
		    vm(v3-1)  = 1
		    
		  else
		    self.AddError("Upper bound for " + variable+ " invalid variable")
		    hasError = True
		    
		  end if
		  
		  if hasError then
		    self.AddError("Upper bound for " + variable+ " ignored")
		    
		  else
		    vm(v3) = 1.0
		    
		    AddPreparedConstraint(vm, 1.0, bound)
		    
		  end if
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(nbVariables as integer)
		  self.nbColumns = nbVariables
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


	#tag Property, Flags = &h0
		eco() As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Errors() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		m(-1,-1) As double
	#tag EndProperty

	#tag Property, Flags = &h0
		nbColumns As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		rhs() As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		s(-1) As double
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
		#tag ViewProperty
			Name="m(-1,-1)"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
