$TARGET_URL = "http://localhost:8080"

Write-Host "Test de sécurité : vérification de /actuator/env"
Write-Host "Cible : $TARGET_URL"

try {
    $response = Invoke-WebRequest -Uri "$TARGET_URL/actuator/env" -UseBasicParsing -ErrorAction Stop
    $statusCode = $response.StatusCode
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
}

Write-Host "Code HTTP reçu : $statusCode"

if ($statusCode -eq 200) {
    Write-Host "ERREUR SECURITE : /actuator/env est accessible publiquement"
    Write-Host "Faille OWASP A05 Security Misconfiguration détectée"
    exit 1
} else {
    Write-Host "OK : /actuator/env n'est pas accessible publiquement"
    exit 0
}