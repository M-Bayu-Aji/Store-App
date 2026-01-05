import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/store.dart';
import 'package:shopping_app/pages/carts.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/services/store.dart';
import 'package:shopping_app/widgets/card_store.dart';
import 'package:google_fonts/google_fonts.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool _isLoading = true;
  String? _errorMessage;
  Map<String, List<Store>> _categorizedStores = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _getStores();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getStores() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      
      final storeService = StoreService();
      final data = await storeService.fetchStores('products');
      
      // Group products by category
      Map<String, List<Store>> categorized = {};
      for (var store in data) {
        if (!categorized.containsKey(store.category)) {
          categorized[store.category] = [];
        }
        categorized[store.category]!.add(store);
      }
      
      setState(() {
        _categorizedStores = categorized;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _categorizedStores = {};
        _isLoading = false;
        _errorMessage = e.toString();
      });
      debugPrint('Error: $e');
    }
  }

  Map<String, List<Store>> _getFilteredStores() {
    if (_searchQuery.isEmpty) {
      return _categorizedStores;
    }
    
    Map<String, List<Store>> filtered = {};
    for (var entry in _categorizedStores.entries) {
      List<Store> filteredStores = entry.value.where((store) {
        return store.title.toLowerCase().contains(_searchQuery) ||
               store.description.toLowerCase().contains(_searchQuery) ||
               store.category.toLowerCase().contains(_searchQuery);
      }).toList();
      
      if (filteredStores.isNotEmpty) {
        filtered[entry.key] = filteredStores;
      }
    }
    return filtered;
  }

  void _showProductDetail(Store store) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                
                // Product Image
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      store.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error_outline, size: 50),
                        );
                      },
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Category
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7FA99B).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    store.category.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2C5F5D),
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Title
                Text(
                  store.title,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C5F5D),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Rating
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${store.rating.rate}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C5F5D),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${store.rating.count} reviews)',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Price
                Text(
                  '\$${store.price.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2C5F5D),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Description title
                Text(
                  'Description',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C5F5D),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Description
                Text(
                  store.description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.6,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Add to Cart Button
                ElevatedButton.icon(
                  onPressed: () {
                    final cartProvider = Provider.of<CartProvider>(context, listen: false);
                    
                    // Capture context before popping
                    final scaffoldMessenger = ScaffoldMessenger.of(context);
                    final navigator = Navigator.of(context);
                    
                    cartProvider.addItem(store);
                    Navigator.pop(context);
                    
                    // Show snackbar after closing modal
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('${store.title} added to cart!'),
                        backgroundColor: const Color(0xFF2C5F5D),
                        duration: const Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                          label: 'VIEW CART',
                          textColor: Colors.white,
                          onPressed: () {
                            navigator.push(
                              MaterialPageRoute(
                                builder: (context) => const CartsPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  label: Text(
                    'Add to Cart',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C5F5D),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: $_errorMessage'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _getStores,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'User. ',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF2C5F5D),
                                        ),
                                      ),
                                      const Text('👋', style: TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                ],
                              ),
                              Consumer<CartProvider>(
                                builder: (context, cartProvider, child) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const CartsPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF7FA99B),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          const Icon(
                                            Icons.shopping_cart_outlined,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                          if (cartProvider.itemCount > 0)
                                            Positioned(
                                              right: -6,
                                              top: -15,
                                              child: Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                constraints: const BoxConstraints(
                                                  minWidth: 18,
                                                  minHeight: 18,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${cartProvider.itemCount}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        
                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Find your furnitur...',
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.grey[400],
                                ),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          _searchController.clear();
                                        },
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Categories with products
                        () {
                          final filteredStores = _getFilteredStores();
                          if (filteredStores.isNotEmpty) {
                            return Column(
                              children: filteredStores.entries.map((entry) {
                                return _buildCategorySection(
                                  entry.key,
                                  entry.value,
                                );
                              }).toList(),
                            );
                          } else {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  _searchQuery.isNotEmpty
                                      ? 'No products found for "$_searchQuery"'
                                      : 'No products available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            );
                          }
                        }(),
                        
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Submit action
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Submit button pressed!')),
      //     );
      //   },
      //   backgroundColor: const Color(0xFF2C5F5D),
      //   icon: const Icon(Icons.check, color: Colors.white),
      //   label: Text(
      //     'Submit',
      //     style: GoogleFonts.poppins(
      //       color: Colors.white,
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildCategorySection(String category, List<Store> stores) {
    String formattedCategory = category
        .split(' ')
        .map((word) => word.isEmpty 
            ? '' 
            : word[0].toUpperCase() + word.substring(1))
        .join(' ');
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedCategory,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C5F5D),
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     // Show all action
              //   },
              //   child: Text(
              //     'Show All',
              //     style: GoogleFonts.poppins(
              //       fontSize: 14,
              //       color: const Color(0xFF7FA99B),
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: stores.length,
            itemBuilder: (context, index) {
              return CardStore(
                store: stores[index],
                onTap: () => _showProductDetail(stores[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
