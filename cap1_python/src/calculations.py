import math

def calculate_area(shape):
    shape = shape.lower()
    if shape == "retângulo" or shape == "retangulo":
        width = float(input("Digite a largura (m): "))
        length = float(input("Digite o comprimento (m): "))
        return width * length

    elif shape == "quadrado":
        side = float(input("Digite o lado (m): "))
        return side ** 2

    elif shape == "círculo" or shape == "circulo":
        radius = float(input("Digite o raio (m): "))
        return math.pi * radius ** 2

    else:
        print("Forma geométrica não reconhecida. Usando área padrão de 0.")
        return 0

def calculate_input_quantity(area, quantity_per_area, rows):
    total_quantity = area * quantity_per_area * rows
    return total_quantity
