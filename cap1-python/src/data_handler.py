from calculations import calculate_area, calculate_input_quantity


def add_data(crops_list, data):
    crops_list.append(data)
    print("Dados adicionados com sucesso!")


def display_data(crops_list):
    if not crops_list:
        print("Nenhuma cultura cadastrada ainda.")
        return

    for idx, crop in enumerate(crops_list, start=1):
        print(f"{idx}. Cultura: {crop['crop']}")
        print(f"   - Forma geométrica: {crop['shape']}")
        print(f"   - Área total: {crop['area']:.2f} m²")
        print(f"   - Ruas da lavoura: {crop['rows']}")

        if crop.get("inputs"):
            print("   - Insumos:")
            for insumo in crop["inputs"]:
                print(f"     - Nome: {insumo['input_name']}")
                print(f"       Unidade: {insumo['unit']}")
                print(f"       Quantidade por área: {insumo['quantity_per_area']} {insumo['unit']}/m²")
                print(f"       Quantidade total necessária: {insumo['total_quantity']} {insumo['unit']}")
        else:
            print("   - Nenhum insumo cadastrado.")

        print("---------------------------")


def update_data(crops_list, index):
    if 0 <= index < len(crops_list):
        crop = crops_list[index]
        print(f"Atualizando dados da cultura '{crop['crop']}'")

        crop['crop'] = input("Novo nome da cultura (ou pressione Enter para manter): ") or crop['crop']
        crop['shape'] = input("Nova forma geométrica (ou pressione Enter para manter): ") or crop['shape']

        new_area = input("Deseja recalcular a área? (s/n): ")
        if new_area.lower() == 's':
            crop['area'] = calculate_area(crop['shape'])

        new_rows = input("Novo número de ruas (ou pressione Enter para manter): ")
        if new_rows:
            crop['rows'] = int(new_rows)

        if crop["inputs"]:
            print("\nAtualização de insumos:")
            for i, insumo in enumerate(crop["inputs"], start=1):
                print(f"\nInsumo {i}: {insumo['input_name']} ({insumo['unit']})")

                insumo['input_name'] = input("Novo nome do insumo (ou pressione Enter para manter): ") or insumo[
                    'input_name']
                insumo['unit'] = input("Nova unidade do insumo (ou pressione Enter para manter): ") or insumo['unit']

                new_quantity_per_area = input(
                    f"Nova quantidade por área ({insumo['unit']}/m²) (ou pressione Enter para manter): ")
                if new_quantity_per_area:
                    insumo['quantity_per_area'] = float(new_quantity_per_area)

                insumo['total_quantity'] = calculate_input_quantity(crop['area'], insumo['quantity_per_area'],
                                                                    crop['rows'])

        print("Dados atualizados com sucesso!")
    else:
        print("Índice inválido.")


def delete_data(crops_list, index):
    if 0 <= index < len(crops_list):
        removed = crops_list.pop(index)
        print(f"Cultura '{removed['crop']}' removida com sucesso.")
    else:
        print("Índice inválido.")


def find_crop_index(crops_list, identifier):
    if identifier.isdigit():
        index = int(identifier) - 1
        if 0 <= index < len(crops_list):
            return index
    else:
        for idx, crop in enumerate(crops_list):
            if crop["crop"].lower() == identifier.lower():
                return idx
    return None


