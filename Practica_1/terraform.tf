resource "local_file" "productos" {
  content =  "Lista de productos, nuevo cambio realizado"
  filename = "productos.txt"
}
