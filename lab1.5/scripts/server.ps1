$listener = New-Object System.Net.HttpListener
  $listener.Prefixes.Add('http://localhost:8000/')
  $listener.Start()

  Write-Host "Servidor corriendo en http://localhost:8000/"

  while ($listener.IsListening) {
      $context = $listener.GetContext()
      $response = $context.Response

      $content = Get-Content "index.html" -Raw
      $buffer = [System.Text.Encoding]::UTF8.GetBytes($content)

      $response.ContentLength64 = $buffer.Length
      $response.OutputStream.Write($buffer, 0, $buffer.Length)
      $response.OutputStream.Close()
}
