
import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../pets/pets_screen.dart';
import '../reservations/reservations_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Veterinaria',
      'icon': Icons.medical_services_outlined,
    },
    {
      'name': 'Peluquería',
      'icon': Icons.content_cut,
    },
    {
      'name': 'Paseos',
      'icon': Icons.location_on_outlined,
    },
  ];

void _selectTab(int index) {
  if (index == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PetsScreen(),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _selectedIndex = 0;
        });
      }
    });

    return;
  }else if (index == 2){
Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReservationScreen(),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {
          _selectedIndex = 0;
        });
      }
    });

    return;
  }

  setState(() {
    _selectedIndex = index;
  });

  if (index != 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Esta sección estará disponible próximamente.',
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ENCABEZADO
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(
                      Icons.pets,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'VeteApp.',
                    style: GoogleFonts.poppins(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  const Spacer(),
                  _headerButton(Icons.notifications_none),
                  const SizedBox(width: 8),
                  _headerButton(Icons.arrow_forward),
                ],
              ),

              const SizedBox(height: 38),

              // SALUDO
              Text(
                'TU RINCÓN DE BIENESTAR',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  letterSpacing: 0.4,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                '¡Hola, Sofía!',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkGreen,
                ),
              ),

              Text(
                'Un gran día para cuidar a quien siempre está a tu lado.',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 25),

              // BANNER PRINCIPAL
              _buildBanner(),

              const SizedBox(height: 32),

              // SERVICIOS
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Cuidado para cada momento',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _selectTab(2);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Ver todos los servicios',
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward,
                          size: 17,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Text(
                'Descubre lo que podemos hacer por tu mejor amigo.',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 8),

              // TARJETAS DE SERVICIOS
              ..._services.map(
                (service) => _buildServiceCard(
                  service['name'] as String,
                  service['icon'] as IconData,
                ),
              ),

              const SizedBox(height: 22),

              // PRÓXIMA CITA
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Próxima cita',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectTab(3),
                    child: Text(
                      'Ver solicitudes',
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Aquí aparecerán tus próximas citas.',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // MENÚ INFERIOR
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _headerButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.softGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Icon(
          icon,
          size: 19,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 192,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                color: AppColors.primary,
                padding: const EdgeInsets.fromLTRB(20, 20, 8, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '✧  ELLOS MERECEN LO MEJOR',
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightGreen,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Más momentos felices,',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'menos preocupaciones.',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: AppColors.lightGreen,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _selectTab(1),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Explorar servicios',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 17),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/images/dog_banner.jpg',
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.lightGreen,
                    child: const Icon(
                      Icons.pets,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String name, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 3,
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.lightGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 22,
          ),
        ),
        title: Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGreen,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          color: AppColors.primary,
          size: 20,
        ),
        onTap: () => _selectTab(1),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Inicio'},
      {'icon': Icons.favorite_border, 'label': 'Mascotas'},
      {'icon': Icons.calendar_month_outlined, 'label': 'Solicitudes'},
      {'icon': Icons.people_outline, 'label': 'Proveedores'},
    ];

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _selectTab,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grayGreen,
      selectedFontSize: 9,
      unselectedFontSize: 9,
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item['icon'] as IconData),
          label: item['label'] as String,
        );
      }).toList(),
    );
  }
}
