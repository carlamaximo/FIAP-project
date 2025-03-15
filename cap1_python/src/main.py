from calculations import calculate_area, calculate_input_quantity
from data_handler import add_data, update_data, delete_data, display_data, find_crop_index

crops = []

def menu():
    print("\n===== FarmTech Solutions =====")
    print("[1] - Inserir dados")
    print("[2] - Exibir dados")
    print("[3] - Atualizar dados")
    print("[4] - Deletar dados")
    print("[5] - Sair")

    choice = input("Escolha uma opção: ")
    return choice


def main():
    while True:
        option = menu()

        if option == "1":
            if len(crops) >= 2:
                print("Você já inseriu as 2 culturas suportadas.")
                continue

            crop_name = input("Informe o nome da cultura: ")
            geometry_shape = input("Forma geométrica (retângulo/quadrado/círculo): ")
            area = calculate_area(geometry_shape)
            rows = int(input("Quantas ruas tem a lavoura? "))

            inputs = []
            while True:
                input_name = input("Nome do insumo/produto: ")
                unit = input("Unidade do insumo (ex: litros, kg): ")
                quantity_per_area = float(input(f"Quantidade do insumo por unidade de área ({unit}/m²): "))
                total_quantity = calculate_input_quantity(area, quantity_per_area, rows)

                inputs.append({
                    "input_name": input_name,
                    "unit": unit,
                    "quantity_per_area": quantity_per_area,
                    "total_quantity": total_quantity
                })

                more = input("Deseja adicionar mais um insumo? (s/n): ")
                if more.lower() != 's':
                    break

            data_entry = {
                "crop": crop_name,
                "shape": geometry_shape,
                "area": area,
                "rows": rows,
                "inputs": inputs
            }

            add_data(crops, data_entry)

        elif option == "2":
            print("Essas são suas culturas cadastradas:")
            display_data(crops)

        elif option == "3":
            print("Essas são suas culturas cadastradas:")
            display_data(crops)
            identifier = input("Digite o número ou nome da cultura que deseja atualizar: ")
            index = find_crop_index(crops, identifier)
            if index is not None:
                update_data(crops, index)
            else:
                print("Cultura não encontrada.")

        elif option == "4":
            print("Essas são suas culturas cadastradas:")
            display_data(crops)
            identifier = input("Digite o número ou nome da cultura que deseja deletar: ")
            index = find_crop_index(crops, identifier)
            if index is not None:
                delete_data(crops, index)
            else:
                print("Cultura não encontrada.")

        elif option == "5":
            print("Encerrando aplicação.")
            break

        else:
            print("Opção inválida. Tente novamente.")


if __name__ == "__main__":
    main()
