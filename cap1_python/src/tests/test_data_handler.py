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
        data = {'crop': 'Milho', 'shape': 'quadrado', 'area': 100, 'rows': 5, 'inputs': []}
        add_data(self.crops, data)
        self.assertEqual(len(self.crops), 1)
        self.assertEqual(self.crops[0]['crop'], 'Milho')

    @patch('builtins.print')
    def test_display_data_empty(self, mock_print):
        display_data([])
        mock_print.assert_called_with("Nenhuma cultura cadastrada ainda.")

    @patch('builtins.print')
    def test_display_data(self, mock_print):
        self.crops.append({'crop': 'Soja', 'shape': 'círculo', 'area': 150, 'rows': 3, 'inputs': []})
        display_data(self.crops)
        mock_print.assert_any_call("1. Cultura: Soja")

@patch('builtins.input', side_effect=['Arroz', '', 's', '200', '4', '', '', '', ''])  # Adicione valores extras
@patch('calculations.calculate_area', return_value=200)
def test_update_data(self, mock_calculate_area, mock_input):
    self.crops.append({'crop': 'Trigo', 'shape': 'retângulo', 'area': 120, 'rows': 2, 'inputs': []})
    update_data(self.crops, 0)
    self.assertEqual(self.crops[0]['crop'], 'Arroz')
    self.assertEqual(self.crops[0]['area'], 200)
    self.assertEqual(self.crops[0]['rows'], 4)

    def test_delete_data(self):
        self.crops.append({'crop': 'Cana', 'shape': 'retângulo', 'area': 80, 'rows': 2, 'inputs': []})
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