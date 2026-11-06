$baseUrl = "http://localhost:8000/api/v1"

$headers = @{
    "Content-Type" = "application/json"
    "Accept" = "application/json"
}

Write-Host "===> Sembrando Libros..." -ForegroundColor Cyan
$book1 = @{
    isbn = "978-0132350884"
    title = "Clean Code"
    author = "Robert C. Martin"
    published_year = 2008
    genre = "Software"
    total_copies = 5
    available_copies = 5
} | ConvertTo-Json

$resBook = Invoke-RestMethod -Uri "$baseUrl/books" -Method Post -Body $book1 -Headers $headers
$bookId = $resBook.id
if (-not $bookId) { $bookId = $resBook.data.id }

Write-Host "===> Sembrando Miembros..." -ForegroundColor Cyan
$member1 = @{
    document_number = "1077723683"
    first_name = "Cristian Camilo"
    last_name = "Bastidas Navarro"
    email = "cristiancamilo19982006@gmail.com"
    phone = "3112513610"
} | ConvertTo-Json

$resMember = Invoke-RestMethod -Uri "$baseUrl/members" -Method Post -Body $member1 -Headers $headers
$memberId = $resMember.id
if (-not $memberId) { $memberId = $resMember.data.id }

Write-Host "===> Sembrando Prestamo..." -ForegroundColor Cyan
$loan1 = @{
    member_id = $memberId
    book_ids = @($bookId)
    due_date = "2026-11-20"
} | ConvertTo-Json

Invoke-RestMethod -Uri "$baseUrl/loans" -Method Post -Body $loan1 -Headers $headers

Write-Host "===> Sembrado completado con exito." -ForegroundColor Green
