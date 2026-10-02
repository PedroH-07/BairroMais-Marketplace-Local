import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/theme.dart';
import 'cart_screen.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({super.key});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  // Lista que vai guardar os produtos vindos da base de dados
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Mapeia a quantidade de cada produto selecionado usando o nome (ou ID) como chave
  final Map<String, int> _itemQuantities = {};

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  // Função para carregar os produtos do Supabase uma única vez ao abrir a tela
  Future<void> _fetchProducts() async {
    try {
      final response = await Supabase.instance.client.from('products').select();
      setState(() {
        _products = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  // Calcula a quantidade total de itens no carrinho
  int get _totalItemsCount {
    int total = 0;
    _itemQuantities.forEach((key, value) {
      total += value;
    });
    return total;
  }

  // Calcula o preço total estimado do carrinho
  double _calculateTotalPrice() {
    double total = 0.0;
    for (var product in _products) {
      final title = product['name'] ?? '';
      final count = _itemQuantities[title] ?? 0;
      if (count > 0) {
        final priceString = product['price']?.toString() ?? '0.0';
        final price = double.tryParse(priceString) ?? 0.0;
        total += price * count;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryGreen))
            : _errorMessage != null
                ? Center(child: Text('Erro ao carregar produtos: $_errorMessage'))
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Capa e Botões Superiores
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.store, size: 60, color: Colors.grey),
                                    ),
                                  ),
                                  // Botão Voltar
                                  Positioned(
                                    top: 12,
                                    left: 12,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        icon: const Icon(Icons.arrow_back, color: AppTheme.textDark),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                  ),
                                  // Ícone do Carrinho Topo
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Stack(
                                        children: [
                                          const Icon(Icons.shopping_bag_outlined, color: AppTheme.textDark),
                                          if (_totalItemsCount > 0)
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                padding: const EdgeInsets.all(3),
                                                decoration: const BoxDecoration(
                                                  color: AppTheme.secondaryOrange,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text(
                                                  '$_totalItemsCount',
                                                  style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Logo do Produtor
                                  Positioned(
                                    bottom: -20,
                                    left: 20,
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.05),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: const Text('🥬', style: TextStyle(fontSize: 28)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 28),

                              // Informações do Produtor
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Horta & Pomar do Zé',
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 18),
                                        const SizedBox(width: 4),
                                        const Text('4.9', style: TextStyle(fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 8),
                                        const Text('•', style: TextStyle(color: Colors.grey)),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            'Hortifrúti',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: AppTheme.primaryGreen,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),

                                    // Banner Proposta Local
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreen.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: const [
                                          Text('🌱 ', style: TextStyle(fontSize: 14)),
                                          Expanded(
                                            child: Text(
                                              'Produtos orgânicos direto da agricultura familiar',
                                              style: TextStyle(fontSize: 12, color: AppTheme.primaryGreen, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Filtros de Categoria
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          _filterChip('Mais Vendidos', isSelected: true),
                                          _filterChip('Verduras'),
                                          _filterChip('Frutas'),
                                          _filterChip('Geleias'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Lista Dinâmica de Produtos
                                    _products.isEmpty
                                        ? const Center(child: Text('Nenhum produto disponível no momento.'))
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: _products.length,
                                            itemBuilder: (context, index) {
                                              final product = _products[index];
                                              final title = product['name'] ?? 'Produto';
                                              final unit = product['unit'] ?? 'Unidade';
                                              final priceValue = product['price']?.toString() ?? '0.00';
                                              final formattedPrice = 'R\$ ${priceValue.replaceAll('.', ',')}';
                                              
                                              final currentCount = _itemQuantities[title] ?? 0;

                                              return _productCard(
                                                title: title,
                                                unit: unit,
                                                price: formattedPrice,
                                                count: currentCount,
                                                onIncrement: () {
                                                  setState(() {
                                                    _itemQuantities[title] = currentCount + 1;
                                                  });
                                                },
                                                onDecrement: () {
                                                  setState(() {
                                                    if (currentCount > 0) {
                                                      _itemQuantities[title] = currentCount - 1;
                                                    }
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Barra Flutuante de Carrinho Dinâmica
                      if (_totalItemsCount > 0)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(
                                    itemQuantities: _itemQuantities,
                                    products: _products,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryGreen,
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text('$_totalItemsCount', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                const Text('Ver Carrinho', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                Text(
                                  'R\$ ${_calculateTotalPrice().toStringAsFixed(2).replaceAll('.', ',')}',
                                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
      ),
    );
  }

  Widget _filterChip(String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textDark,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: isSelected ? AppTheme.primaryGreen : Colors.white,
        side: BorderSide(color: isSelected ? AppTheme.primaryGreen : Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _productCard({
    required String title,
    required String unit,
    required String price,
    required int count,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.eco, color: AppTheme.primaryGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(unit, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(price, style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            count > 0
                ? Row(
                    children: [
                      IconButton(
                        onPressed: onDecrement,
                        icon: const Icon(Icons.remove_circle_outline, color: AppTheme.primaryGreen),
                      ),
                      Text('$count', style: const TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: onIncrement,
                        icon: const Icon(Icons.add_circle, color: AppTheme.secondaryOrange),
                      ),
                    ],
                  )
                : CircleAvatar(
                    backgroundColor: AppTheme.secondaryOrange,
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: onIncrement,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}