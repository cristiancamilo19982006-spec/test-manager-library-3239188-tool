$baseUrl = "http://localhost:8000/api/v1"

Write-Host "===> Sembrando Libros..." -ForegroundColor Cyan
$books = @(
    @{ isbn = "978-0132350884"; title = "Clean Code"; author = "Robert C. Martin"; published_year = 2008; genre = "Software Engineering"; total_copies = 5 },
    @{ isbn = "978-0201633610"; title = "Design Patterns"; author = "Erich Gamma et al."; published_year = 1994; genre = "Software Architecture"; total_copies = 3 },
    @{ isbn = "978-0134494166"; title = "Clean Architecture"; author = "Robert C. Martin"; published_year = 2017; genre = "Architecture"; total_copies = 4 }
)

foreach ($b in $books) {
    $body = $b | ConvertTo-Json
    Invoke-RestMethod -Uri "$baseUrl/books" -Method Post -ContentType "application/json" -Body $body
}

Write-Host "===> Sembrando Miembros..." -ForegroundColor Cyan
$members = @(
    @{ document_number = "1075200001"; first_name = "Carlos"; last_name = "Gomez"; email = "carlos@example.com"; phone = "3101112233" },
    @{ document_number = "1075200002"; first_name = "Laura"; last_name = "Perez"; email = "laura@example.com"; phone = "3202223344" }
)

foreach ($m in $members) {
    $body = $m | ConvertTo-Json
    Invoke-RestMethod -Uri "$baseUrl/members" -Method Post -ContentType "application/json" -Body $body
}

Write-Host "===> Sembrando Prestamo de prueba..." -ForegroundColor Cyan
$loanBody = @{
    member_id = 1
    book_ids = @(1, 2)
    due_date = (Get-Date).AddDays(7).ToString("yyyy-MM-dd")
} | ConvertTo-Json

Invoke-RestMethod -Uri "$baseUrl/loans" -Method Post -ContentType "application/json" -Body $loanBody

Write-Host "Sembrado completado con exito." -ForegroundColor Green
