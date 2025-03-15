import unittest
from unittest.mock import patch
import math
import sys
import os

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from calculations import calculate_area, calculate_input_quantity

class TestCalculateArea(unittest.TestCase):
    
    @patch('builtins.input', side_effect=['5', '10'])
    def test_calculate_area_rectangle(self, mock_input):
        self.assertEqual(calculate_area('retângulo'), 50)
    
    @patch('builtins.input', side_effect=['4'])
    def test_calculate_area_square(self, mock_input):
        self.assertEqual(calculate_area('quadrado'), 16)
    
    @patch('builtins.input', side_effect=['3'])
    def test_calculate_area_circle(self, mock_input):
        self.assertAlmostEqual(calculate_area('círculo'), math.pi * 9, places=5)
    
    def test_calculate_area_invalid_shape(self):
        self.assertEqual(calculate_area('triângulo'), 0)

class TestCalculateInputQuantity(unittest.TestCase):
    def test_calculate_input_quantity(self):
        self.assertEqual(calculate_input_quantity(10, 2, 3), 60)
        self.assertEqual(calculate_input_quantity(5, 1.5, 4), 30)
        self.assertEqual(calculate_input_quantity(0, 3, 5), 0)

if __name__ == '__main__':
    unittest.main()