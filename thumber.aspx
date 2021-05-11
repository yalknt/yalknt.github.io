<% ' import all relevant namespaces				%>
<%@  import namespace="System"					%>
<%@  import namespace="System.Drawing"			%>
<%@  import namespace="System.Drawing.Imaging"	%>
<%@	 import namespace="System.IO"				%>

<script runat="server">

function newthumbSize(currentwidth, currentheight)


        ' Calculate the Size of the new image
               
               Dim tempMultiplier as Double
               
               If currentheight > currentwidth-1 Then ' portrait
                  tempMultiplier = request("genislik") / currentheight
               Else
                  tempMultiplier = request("boy") / currentwidth
               End If

               
               Dim newSize as New Size(CInt(currentwidth * tempMultiplier), CInt(currentheight * tempMultiplier))


               return newSize
end function


sub sendFile()

	' create new image and bitmap objects. Load the image file and put into a resized bitmap.
		Dim g as System.Drawing.Image = System.Drawing.Image.FromFile(server.mappath(request("src")))
		dim thisFormat=g.rawformat
		
		dim thumbSize as new size
		thumbSize=newthumbSize(g.width,g.height)
		
		Dim imgOutput as New Bitmap(g, thumbSize.width, thumbSize.height)
	
	' set the contenttype
		
		if thisformat.equals(system.drawing.imaging.imageformat.Gif) then
			response.contenttype="image/gif"
		else
			response.contenttype="image/jpeg"
		end if	
		
	
	
	' send the resized image to the viewer
		imgOutput.save(response.outputstream, thisformat) 'output to the user
	
	' tidy up
		g.dispose()
		imgOutput.dispose()
		
end sub		

sub sendError()

	' if no height, width, src then output "error"
		dim imgOutput as new bitmap(120, 120, pixelformat.format24bpprgb)
		dim g as graphics = graphics.fromimage(imgOutput) ' create a new graphic object from the above bmp
		g.clear(color.yellow) ' blank the image
		g.drawString("ERROR!", new font("verdana",14,fontstyle.bold),systembrushes.windowtext, new pointF(2,2))

	' set the contenttype
		response.contenttype="image/gif"
	
	' send the resized image to the viewer
		imgOutput.save(response.outputstream, imageformat.gif) ' output to the user
	
	' tidy up
		g.dispose()
		imgOutput.dispose()


end sub


</script>

 

<% 
	
	
	' make sure nothing has gone to the client
		response.clear 
	
	
		if request("src")="" then

			call sendError()
			
		else
	
			if file.exists(server.mappath(request("src"))) then
				call sendFile()	
			else
				call sendError()
			end if	
	
		end if
	
	
		response.end
	
%>

