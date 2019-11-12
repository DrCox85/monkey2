Namespace mx2

Class Incbin
	
	Function Create:String( _path:String, _fdecl:FileDecl )
		
		Print "#INCBIN:"+_path
		
		Local _appPath:=ExtractDir( _fdecl.path )
		Local _bytesCount:=64
		Local _fileName:=StripDir( _path )
		_fileName=_fileName.Replace( ".","_" )
		_fileName=_fileName.Replace( "-","_" )
		If GetFileType( _appPath+"incbin/" )=FileType.None
			CreateDir( _appPath+"incbin/" )
		End
		
		Local _incbinData:FileStream=FileStream.Open( _path,"r" )
		Local _file:FileStream=FileStream.Open( _appPath+"incbin/"+_fileName+"_incbin.monkey2","w" )
		Local _linesSplit:String[]
		Local _line:String
		Local _counter:Int
		Local _splitCounter:Int
		Local _stringSize:Int=( _incbinData.Length/_bytesCount )+1
		
		_file.WriteLine( "Namespace "+_fdecl.nmspace )
		_file.WriteLine( "Private" )
		_file.WriteLine( "Class Incbin_"+_fileName )
		_file.WriteLine( "Global Name:=~q"+_fileName+"~q" )
		_file.WriteLine( "Global Line:=New String["+_stringSize+"]" )
		_file.WriteLine( "Method New()" )
		
		'Write Data
		For Local a:=0 To _incbinData.Length-1
			_line+=String( _incbinData.ReadByte() )+","
			_counter+=1
			If _counter=_bytesCount 
				_file.WriteLine( "Line["+_splitCounter+"]=~q"+_line+"~q" )
				_counter=0
				_line=""
				_splitCounter+=1
			End				
		Next
		
		If _counter>0 Then _file.WriteLine( "Line["+_splitCounter+"]=~q"+_line+"~q" )
		
		_file.WriteLine( "End")	
		_file.WriteLine( "Global count:="+_splitCounter )
		_file.WriteLine( "Global size:="+_incbinData.Length )
		_file.WriteLine( "End" )
		_file.WriteLine( "Public" )
		_file.WriteLine( "Function incbin_"+_fileName+":DataBuffer()" )
		_file.WriteLine( "Local _buf:=New Incbin_"+_fileName )
		_file.WriteLine( "Local _dataBuffer:=New DataBuffer(_buf.size)" )
		_file.WriteLine( "Local splitLine:String[]" )
		_file.WriteLine( "Local counter:Int" )
		_file.WriteLine( "For Local a:=0 to _buf.count" )
		_file.WriteLine( "Local _line:=_buf.Line[a]" )
		_file.WriteLine( "splitLine=_line.Split(~q,~q)" )
		_file.WriteLine( "For Local b:=0 To splitLine.Length-2" )
		_file.WriteLine( "_dataBuffer.PokeByte(counter,Byte(splitLine[b]))" )
		_file.WriteLine( "counter+=1" )
		_file.WriteLine( "Next" )
		_file.WriteLine( "Next" )
		_file.WriteLine( "Return _dataBuffer" )
		_file.WriteLine( "End" )

		_file.Close()
		_incbinData.Close()
		Return "incbin/"+_fileName+"_incbin.monkey2"
	End
End
