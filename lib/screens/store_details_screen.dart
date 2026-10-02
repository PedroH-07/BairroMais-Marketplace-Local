import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'cart_screen.dart';

class StoreDetailsScreen extends StatefulWidget {
  const StoreDetailsScreen({super.key});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
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
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: const BoxDecoration(
                                      color: AppTheme.secondaryOrange,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 9)),
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

                          // Lista de Produtos
                          _productCard(
                            title: 'Couve Manteiga',
                            unit: 'Maço',
                            price: 'R\$ 3,50',
                            showCounter: true,
                          ),
                          _productCard(
                            title: 'Rúcula Orgânica',
                            unit: 'Bandeja 100g',
                            price: 'R\$ 5,90',
                          ),
                          _productCard(
                            title: 'Manga Palmer',
                            unit: 'Unidade ~400g',
                            price: 'R\$ 4,50',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Barra Flutuante de Carrinho
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
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
                      child: const Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const Text('Ver Carrinho', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const Text('R\$ 3,50', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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
    bool showCounter = false,
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
            showCounter
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_circle_outline, color: AppTheme.primaryGreen),
                      ),
                      Text('$itemCount', style: const TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle, color: AppTheme.secondaryOrange),
                      ),
                    ],
                  )
                : CircleAvatar(
                    backgroundColor: AppTheme.secondaryOrange,
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}