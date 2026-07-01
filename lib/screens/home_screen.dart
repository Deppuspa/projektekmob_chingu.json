import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/food_item.dart';
import '../theme/app_theme.dart';
import '../widgets/banner_promo.dart';
import '../widgets/category_chip.dart';
import '../widgets/food_card_home.dart';
import '../widgets/section_header.dart';
import 'checkout_screen.dart';
import '../services/api_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ApiService _apiService = ApiService();

  static final List<Map<String, dynamic>> _categories = [
  {'label': 'Makanan Berat', 'icon': Icons.restaurant},
  {'label': 'Cemilan', 'icon': Icons.cookie_outlined},
  {'label': 'Roti & Kue', 'icon': Icons.bakery_dining},
  {'label': 'Sayuran', 'icon': Icons.eco_outlined},
  {'label': 'Minuman', 'icon': Icons.local_drink_outlined},
];

  List<FoodItem> _recommendations = [];
  List<FoodItem> _allFoods = [];
  List<FoodItem> _filteredFoods = [];

final TextEditingController _searchController =
    TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
  super.initState();
  loadFoods();
}

void searchFoods(String keyword) {
  setState(() {
    if (keyword.isEmpty) {
      _filteredFoods = List.from(_recommendations);
    } else {
      _filteredFoods = _allFoods.where((food) {
        return food.name
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            food.restaurantName
                .toLowerCase()
                .contains(keyword.toLowerCase());
      }).toList();
    }
  });
}

Future<void> loadFoods() async {
   try {
    final data = await _apiService.getFoods();

    setState(() {
      _allFoods = data
      .map((e) => FoodItem.fromJson(e))
      .toList();

      _recommendations = _allFoods.take(5).toList();
      _filteredFoods = List.from(_recommendations);

      isLoading = false;
    });
  } catch (e) {
    print(e);

    setState(() {
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: isLoading
        ? const Center(
          child: CircularProgressIndicator(),
        )
        :CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildSearchBar(context),
                    const SizedBox(height: 16),
                    const BannerPromo(),
                    const SizedBox(height: 24),
                    _buildCategories(),
                    const SizedBox(height: 24),
                    _buildRecommendationsHeader(context),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => FoodCardHome(
                    item: _filteredFoods[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CheckoutScreen(item: _filteredFoods[index]),
                      ),
                    ),
                  ),
                  childCount: _filteredFoods.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              child: const Icon(Icons.person,
                  color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Food Hero!',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 13, color: AppColors.primary),
                    const SizedBox(width: 2),
                    Text(
                      'Jogja, Banguntapan',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: AppColors.textPrimary, size: 26),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: searchFoods,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Cari makanan atau restoran...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Kategori',
          actionText: 'See all',
          onAction: () {},
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories
                .asMap()
                .entries
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.only(
                      right: e.key < _categories.length - 1 ? 16 : 0,
                    ),
                    child: CategoryChip(
                      label: e.value['label'],
                      icon: e.value['icon'],
                      isSelected: e.key == 0,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Rekomendasi di Sekitarmu',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const Icon(Icons.tune, color: AppColors.textPrimary, size: 22),
      ],
    );
  }
}