
' ---------------------------------------------------------------------------------------
' Search for "Eiffel tower", create a Pdf and insert a screen capture of the page result.
' ---------------------------------------------------------------------------------------

Class Script
    Dim driver

    Sub Class_Initialize
        Set driver = CreateObject("Selenium.FirefoxDriver")
        Set pdf = CreateObject("Selenium.PdfFile")
        
        'Define the PDF page size and margins
        pdf.SetPageSize 210, 297, "mm"
        pdf.SetMargins 5, 5, 5, 15, "mm"
        
        'Add a title and some text to the PDF
        pdf.AddTextCenter "Search for Eiffel tower", 14, true
        pdf.AddSpace 10
        pdf.AddText "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " & _
            "Etiam sit amet libero arcu, et molestie purus. Ut in sem lacus, " & _
            "sit amet rhoncus erat. In aliquet arcu at nunc porta sollicitudin. " & _
            "Cras ante nisl, hendrerit quis bibendum quis, egestas vitae mi."
        
        'Open the search page and maximize the window
        driver.Get "https://www.google.co.uk"
        driver.Window.Maximize
        
        'Add a title, the URL and a screenshot to the PDF
        pdf.AddTitle "Search page"
        pdf.AddLink driver.Url
        pdf.AddImage driver.TakeScreenshot()
        
        'Search for Eiffel tower
        driver.Get "/search?q=Eiffel+tower"
        
        'Add a title, the URL and a screenshot to the PDF
        pdf.AddTitle "Results page"
        pdf.AddLink driver.Url
        pdf.AddImage driver.TakeScreenshot()
        
        'Save the PDF to a file
        pdf.SaveAs "my-capture-ff.pdf"
    End Sub

    Sub Class_Terminate
        driver.Quit    'Stops the browser
    End Sub
End Class

Set s = New Script
