
Namespace test

#Import "<reflection>"

#Reflect test

Enum E
	A,B,C
End

Function Test( e:E )
	
	Print "e="+Int( e )
End

Function Main()
	
	Local e:=E.A
	
	Print Typeof( e )
	
	Local type:=Typeof( e )
	
	For Local decl:=Eachin type.GetDecls()
		
		Local e:=Cast<E>( decl.Get( Null ) )
		
		Print decl.Name+"="+Int( e )'Cast<Int>( decl.Get( Null ) )
	
	Next
	
	Local rtest:=TypeInfo.GetType( "test" ).GetDecl( "Test" )
	
	rtest.Invoke( Null,New Variant[]( E.C ) )
	
	

End
