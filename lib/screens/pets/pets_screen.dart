
import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  int _selectedIndex = 2;

  final List<Map<String, String>> _pets = [
    {
      'name': 'Max',
      'type': 'Perro',
      'breed': 'Golden retriever',
      'age': '3 años',
      'image': 'assets/images/max_dog.jpg',
    },
    {
      'name': 'Mila',
      'type': 'Gato',
      'breed': 'Gato mestizo',
      'age': '2 años',
      'image': 'assets/images/mila_cat.jpg',
    },
  ];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _addPet() {
    final nameController = TextEditingController();
    final typeController = TextEditingController(text: 'Perro');
    final breedController = TextEditingController();
    final ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Agregar mascota',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: AppColors.darkGreen,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _formField(nameController, 'Nombre de tu mascota'),
                const SizedBox(height: 12),
                _formField(typeController, 'Tipo: Perro o Gato'),
                const SizedBox(height: 12),
                _formField(breedController, 'Raza'),
                const SizedBox(height: 12),
                _formField(
                  ageController,
                  'Edad (ej. 2 años)',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final name = nameController.text.trim();
                final type = typeController.text.trim();
                final breed = breedController.text.trim();
                final age = ageController.text.trim();

                if (name.isEmpty ||
                    type.isEmpty ||
                    breed.isEmpty ||
                    age.isEmpty) {
                  _showMessage('Completa todos los campos.');
                  return;
                }

                setState(() {
                  _pets.add({
                    'name': name,
                    'type': type,
                    'breed': breed,
                    'age': age,
                    'image': '',
                  });
                });

                Navigator.pop(dialogContext);
                _showMessage('$name se agregó a tu familia.');
              },
              child: const Text('Guardar mascota'),
            ),
          ],
        );
      },
    ).then((_) {
      nameController.dispose();
      typeController.dispose();
      breedController.dispose();
      ageController.dispose();
    });
  }

  Widget _formField(
    TextEditingController controller,
    String label,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(fontSize: 12),
        filled: true,
        fillColor: AppColors.softGreen,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPetCard(Map<String, String> pet) {
    final image = pet['image'] ?? '';

    return Container(
      height: 148,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.grayGreen),
        borderRadius: BorderRadius.circular(17),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          SizedBox(
            width: 121,
            height: double.infinity,
            child: image.isNotEmpty
                ? Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _petPlaceholder(),
                  )
                : _petPlaceholder(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(13, 12, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.pets,
                          size: 13,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          pet['type'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    pet['name'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: AppColors.darkGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${pet['breed']} · ${pet['age']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 1,
                    color: AppColors.grayGreen,
                  ),
                  InkWell(
                    onTap: () {
                      _showMessage(
                        'Próximamente podrás buscar cuidados para ${pet['name']}.',
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Row(
                        children: [
                          Text(
                            'Buscar cuidados',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _petPlaceholder() {
    return Container(
      color: AppColors.softGreen,
      child: const Center(
        child: Icon(
          Icons.pets,
          size: 45,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Inicio'},
      {'icon': Icons.search, 'label': 'Buscar'},
      {'icon': Icons.favorite_border, 'label': 'Mascotas'},
      {'icon': Icons.calendar_month_outlined, 'label': 'Solicitudes'},
      {'icon': Icons.people_outline, 'label': 'Proveedores'},
    ];

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });

        if (index == 0) {
          Navigator.pop(context);
        } else if (index != 2) {
          _showMessage('Esta sección estará disponible próximamente.');
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.darkGreen,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ENCABEZADO
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.grayGreen),
                ),
              ),
              child: Row(
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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      color: AppColors.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // CONTENIDO
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TU PEQUEÑA GRAN FAMILIA',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Mis mascotas',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkGreen,
                      ),
                    ),
                    Text(
                      'Su mundo gira a tu alrededor. El nuestro, alrededor de ellos.',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // BOTÓN AGREGAR
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _addPet,
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: Text(
                          'Agregar mascota',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkGreen,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // MENSAJE INFORMATIVO
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.softGreen,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.pets,
                              color: AppColors.darkGreen,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cada mascota tiene una historia única.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Guarda sus datos aquí para encontrar el cuidado perfecto cuando lo necesite.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // LISTA DE MASCOTAS
                    ..._pets.map(_buildPetCard),

                    // AGREGAR OTRA MASCOTA
                    InkWell(
                      onTap: _addPet,
                      borderRadius: BorderRadius.circular(17),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.softGreen,
                          border: Border.all(
                            color: AppColors.grayGreen,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: AppColors.lightGreen,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '¿Hay alguien más en la familia?',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkGreen,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Agrega otra mascota a tu perfil',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }
}
