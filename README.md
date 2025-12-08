# sl-xj-lib-NumericalMethods


Numerical methods for Xojo

Based on 

- the book ‘Numerical Recipes in Pascal: The Art of Scientific Computing’ by S.A. Teukolsky, W.T. Vetterling, and B.P. Flannery, Cambridge University Press 1986 
- the English version of the document ‘Numerical Methods in Physics (515.421)’ by Prof. Heinrich Sormann, Institut für Theoretische Physik - Computational Physics TU Graz,  2013


The library is provided as is for free and it is available in a github repo. Please give credit to the author when applicable. 
In the unlikely case someone finds a bug ;), please use github to report the issue.

Interfaces are provided in a distinct library to use the library sl-xj-lib-data for data handling.

Each method has references to the source, please refer to the reference document(s) for background information.


## About Xojo version
Tested with Xojo 2025 release 2.1 on Mac.



## What is covered
Notes: 

- a vector is a one dimension array
- a matrix is a two dimensions array

Methods are grouped as follows:

- Helper methods to handle vector and matrices in NumericalMethodMatrixHelpers
- Basic matrix related methods in NumericalMethodMatrix
- Altering the geometry in NumericalMethodsMatrixGeometry
- Handling LU decomposition to solve a systems of linear equations in NumericalMethodMatrixLUDecomposition




### NumericalMethodMatrixHelpers

check_matrix(msg, c(,), e(,))
Compare the calculated matrix c with the expected matrix e


MatCopy(a())
Create a copy of the vector received as parameter

MatCopy(a(,))
Create a copy of the matrix received as parameter

MatDebugLog(a())
Print the vector on debugLog as a column vector

MatDebugLog(a(,))
Print the matrix on debugLog

SetArrayRow


MatSameSize(a(,), b(,))
Returns true is the two matrices have the same shape

MatIsSqua
re a(,))
Returns true if the matrix is a square matrix

SetArrayRow(a(,), rowIndex, r())
Set the the values of the row rowIndex to the values in r


### NumericalMethodMatrix

CrossProduct(a(,))

DotProducts(a(), b()) returns the dot product of vector a() and vector b() 

MatAdd(a(,), b(,))
Returns a matrix representing the sum of the two matrices

MatMutl(a(,), b(,))
Returns a matrix representing the product of the two matrices

MatMutl(a(,), b())
Returns a matrix representing the product of the matrix a with vector b

MatMutl(a(), b(,))
Returns a matrix representing the product of the vector a with matrix b

MatMutl(a(), b())
Returns a matrix representing the product of the vector a with vector b, same as DotProduct()

Transpose(a(,))
Return the transposed matrix a

### NumericalMethodsMatrixGeometry

MatAppendColumn
Append a column to the matrix

ColumnVect 
Returns the selected column from the matrix as a vector

RowVect 
Returns the selected row from the matrix as a vector

ColumnMat()
Create a matrix with one column populated with the vector

RowMat()
Create a matrix with one row populated with the vector

### NumericalMethodMatrixLUDecomposition

LUDecomposition
Implementation of LUDCMP() 

LUBackSubstitution
Implementation of LUBKSB()




## Using sl-xj-lib-data for data handling
The library is available at https://github.com/slo1958/sl-xj-lib-data.git

The easiest way to prepare an array from a clDataTable is to use the following extension:

```xojo

Function GetArray (Extends t as clDataTable, columns() as string) as double(,)
//
// Creates a an array of doubles out of set of columns selected in the table
//
// Parameters:
// - t : Source table
// - columns(): list of columns to return as an two-dimension array of double
//

var ret(-1,-1) as Double

var rowLastIndex as integer = t.LastIndex
var columnLastIndex as integer = columns.LastIndex
var columnTemp() as clAbstractDataSerie

ret.ResizeTo(rowLastIndex, columnLastIndex)

for colIndex as integer = 0 to columns.LastIndex
  columnTemp.Add(t.GetColumn(columns(colIndex)))
  
  if columnTemp(columnTemp.LastIndex) = nil then System.DebugLog(CurrentMethodName+": Missing data column  " + columns(colIndex)+ " column " + colIndex.ToString + " will be populated with zeroes.")
next

for rowIndex as integer = 0 to t.LastIndex
  
  for colIndex as integer = 0 to columnTemp.LastIndex
    if columnTemp(colIndex) <> nil then ret(rowIndex, colIndex) = columnTemp(colIndex).GetElementAsNumber(rowIndex)
    
  next
  
next

Return ret


```

The easiest way to save results:


```xojo
Function CreateTableFromArray(TableName as string, a(, ) as Double, mapping() as pair) as clDataTable

//
// Create a new table  with the received array
//

var res as new clDataTable(TableName)

var tempColumns() as clAbstractDataSerie

for each p as pair in mapping
  tempColumns.add(res.AddColumn(new clNumberDataSerie(p.left)))
  
next

for rowIndex as integer = 0 to a.LastIndex(1)
  
  for colIndex as integer = 0 to tempColumns.LastIndex
    tempColumns(colIndex).AddElement(a(rowIndex, mapping(colIndex).Right))
    
  next
  
next

return res
```

Example:

With CalculateVolume() defined as

```xojo
Function CalculateVolume(sourceMeasures(, ) as double) as double()

var rowLastIndex as integer = sourceMeasures.LastIndex(1)

var res() as Double
res.ResizeTo(rowLastIndex)


for rowIndex as integer = 0 to sourceMeasures.LastIndex(1)
  var v as Double = sourceMeasures(rowIndex, 0)
  v = v * sourceMeasures(rowIndex, 1)
  v = v * sourceMeasures(rowIndex, 2)
  res(rowIndex) = v
  
next

return res

```


```xojo

// prepare the clDataTable
…..

// Transfer to a matrix
var a(-1, -1) as double
a = myTable.GetArray(array("Width", "Height”,”length"))

// Process the matrix, add the results as a new column
var b() as double = CalculateVolume(a)
MatAppendColumn(a, b)

// Save the results to a clDataTable
var output as clDataTable = CreateTableFromArray(“Output”, a, array("Width":0, "Height":1,"Length": 2, "Volume":3))

```
