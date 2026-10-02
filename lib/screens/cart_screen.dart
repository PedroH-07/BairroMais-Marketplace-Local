import 'package:flutter/material.dart';
import '../core/theme.dart';

class CartScreen extends StatelessWidget {
  final Map<String, int> itemQuantities;
  final List<Map<String, dynamic>> products;

  const CartScreen({
    super.key,
    required this.itemQuantities,
    required this.products,
  });

  // Filtra apenas os produtos que possuem quantidade maior que 0 no carrinho
  List<Map<String, dynamic>> get _cartItems {
    return products.where((product) {
      final title = product['name'] ?? '';
      return (itemQuantities[title] ?? 0) > 0;
    }).toList();
  }

  double get _subtotal {
    double total = 0.0;
    for (var product in _cartItems) {
      final title = product['name'] ?? '';
      final count = itemQuantities[title] ?? 0;
      final priceString = product['price']?.toString() ?? '0.0';
      final price = double.tryParse(priceString) ?? 0.0;
      total += price * count;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartList = _cartItems;
    const double deliveryFee = 3.00;
    final double totalOrder = _subtotal + deliveryFee;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Meu Carrinho',
              style: TextStyle(color: AppTheme.textDark, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Horta & Pomar do Zé',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: cartList.isEmpty
                    ? const Center(
                        child: Text(
                          'O seu carrinho está vazio.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Lista Dinâmica de Itens no Carrinho
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartList.length,
                              itemBuilder: (context, index) {
                                final product = cartList[index];
                                final title = product['name'] ?? 'Produto';
                                final unit = product['unit'] ?? 'Unidade';
                                final priceValue = double.tryParse(product['price']?.toString() ?? '0.0') ?? 0.0;
                                final count = itemQuantities[title] ?? 0;
                                final itemTotal = priceValue * count;

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
                                          width: 50,
                                          height: 50,
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
                                              Text(
                                                'R\$ ${itemTotal.toStringAsFixed(2).replaceAll('.', ',')} ($count un)',
                                                style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),

                            // Endereço de Entrega
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Endereço de entrega', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text('Alterar', style: TextStyle(color: AppTheme.primaryGreen)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.location_on, color: AppTheme.primaryGreen, size: 20),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text('Rua dos Pinheiros, 412 — Apto 31', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                              Text('Pinheiros, São Paulo · CEP 05422-000', style: TextStyle(color: Colors.grey, fontSize: 11)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Resumo do Pedido Dinâmico
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Resumo do pedido', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Subtotal', style: TextStyle(color: Colors.grey)),
                                        Text('R\$ ${_subtotal.toStringAsFixed(2).replaceAll('.', ',')}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Taxa de entrega local', style: TextStyle(color: Colors.grey)),
                                        Text('R\$ ${deliveryFee.toStringAsFixed(2).replaceAll('.', ',')}', style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    const Divider(height: 24),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        Text('R\$ ${totalOrder.toStringAsFixed(2).replaceAll('.', ',')}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.textDark)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),

              // Botão Confirmar Pedido
              if (cartList.isNotEmpty)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pedido enviado para o produtor local! 🌿'),
                              backgroundColor: AppTheme.primaryGreen,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Confirmar Pedido', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Pagamento na entrega ou via PIX', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}