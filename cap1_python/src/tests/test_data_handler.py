import unittest
from unittest.mock import patch
import sys
import os

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from data_handler import add_data, display_data, update_data, delete_data, find_crop_index

class TestCropManagement(unittest.TestCase):

    def setUp(self):
        self.crops = []

    def test_add_data(self):
        data = {
            'crop': 'Milho',
            'shape': 'quadrado',
            'total_area': 100,
            'cultivation_area': 90,
            'spacing': 1.0,
            'groove_area': 10,
            'rows': 5,
            'inputs': []
        }
        add_data(self.crops, data)
        self.assertEqual(len(self.crops), 1)
        self.assertEqual(self.crops[0]['crop'], 'Milho')

    @patch('builtins.print')
    def test_display_data_empty(self, mock_print):
        display_data([])
        mock_print.assert_called_with("Nenhuma cultura cadastrada ainda.")

    @patch('builtins.print')
    def test_display_data(self, mock_print):
        self.crops.append({
            'crop': 'Soja',
            'shape': 'círculo',
            'total_area': 150,
            'cultivation_area': 140,
            'spacing': 1.0,
            'groove_area': 10,
            'rows': 3,
            'inputs': []
        })
        display_data(self.crops)
        mock_print.assert_any_call("\n===== Cultura 1 =====")

    @patch('builtins.input', side_effect=[
        'Arroz',
        '',
        's',
        '200',
        '1.0',
        1, '', '', ''
    ])
    @patch('calculations.calculate_area', return_value=200)
    def test_update_data(self, mock_calculate_area, mock_input):
        self.crops.append({
            'crop': 'Trigo',
            'shape': 'retângulo',
            'total_area': 120,
            'cultivation_area': 100,
            'spacing': 1.2,
            'groove_area': 20,
            'rows': 2,
            'inputs': [{
                'input_name': 'Insumo X',
                'unit': 'kg',
                'quantity_per_area': 0.5,
                'total_quantity': 50
            }]
        })

        update_data(self.crops, 0)
        self.assertEqual(self.crops[0]['crop'], 'Arroz')
        self.assertEqual(self.crops[0]['total_area'], 200)
        self.assertEqual(self.crops[0]['rows'], 200)

    def test_delete_data(self):
        self.crops.append({
            'crop': 'Cana',
            'shape': 'retângulo',
            'total_area': 80,
            'cultivation_area': 75,
            'spacing': 1.2,
            'groove_area': 5,
            'rows': 2,
            'inputs': []
        })
        delete_data(self.crops, 0)
        self.assertEqual(len(self.crops), 0)

    def test_find_crop_index_by_number(self):
        self.crops.append({'crop': 'Feijão'})
        self.assertEqual(find_crop_index(self.crops, '1'), 0)

    def test_find_crop_index_by_name(self):
        self.crops.append({'crop': 'Tomate'})
        self.assertEqual(find_crop_index(self.crops, 'Tomate'), 0)

    def test_find_crop_index_not_found(self):
        self.assertIsNone(find_crop_index(self.crops, 'Batata'))

if __name__ == '__main__':
    unittest.main()
