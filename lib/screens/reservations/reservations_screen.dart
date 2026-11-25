
import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  int _selectedIndex = 2;

  String _selectedService = 'Peluquería';
  String _selectedPet = 'Max';
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = '3:00 p.m.';

  final List<String> _services = [
    'Veterinaria',
    'Peluquería',
    'Paseos',
    'Guardería',
  ];

  final List<Map<String, String>> _pets = [
    {'name': 'Max', 'details': 'Perro · 3 años'},
    {'name': 'Mila', 'details': 'Gato · 2 años'},
  ];

  final List<String> _times = [
    '8:00 a.m.',
    '9:00 a.m.',
    '10:00 a.m.',
    '2:00 p.m.',
    '3:00 p.m.',
    '4:00 p.m.',
  ];

  String get _serviceDescription {
    switch (_selectedService) {
      case 'Veterinaria':
        return 'La salud de tu mascota es nuestra prioridad ♥';
      case 'Peluquería':
        return 'Porque tu mascota también merece verse increíble ♥';
      case 'Paseos':
        return 'Nuevas aventuras para tu mejor amigo ♥';
      case 'Guardería':
        return 'Un lugar especial para cuidar de tu mascota ♥';
      default:
        return 'El bienestar de tu mascota es lo más importante ♥';
    }
  }

  IconData get _serviceIcon {
    switch (_selectedService) {
      case 'Veterinaria':
        return Icons.medical_services_outlined;
      case 'Peluquería':
        return Icons.content_cut;
      case 'Paseos':
        return Icons.directions_walk;
      case 'Guardería':
        return Icons.home_outlined;
      default:
        return Icons.pets;
    }
  }

  String _weekday(int weekday) {
    const days = [
      'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom',
    ];
    return days[weekday - 1];
  }

  String _month(int month) {
    const months = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic',
    ];
    return months[month - 1];
  }

  String _formattedDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} '
        '${_month(date.month)} ${date.year}';
  }

  void _confirmReservation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Solicitud de $_selectedService para $_selectedPet preparada!',
        ),
        backgroundColor: AppColors.primary,
      ),
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            '¡Reserva preparada!',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: AppColors.darkGreen,
            ),
          ),
          content: Text(
            'Tu solicitud de $_selectedService para $_selectedPet '
            'está lista para continuar.\n\n'
            'Fecha: ${_formattedDate(_selectedDate)}\n'
            'Hora: $_selectedTime\n\n'
            'Esta es una demostración. Todavía no se ha guardado '
            'una cita real.',
            style: GoogleFonts.poppins(fontSize: 12),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionTitle(String number, String title) {
    return Row(
      children: [
        Container(
          width: 21,
          height: 21,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.lightGreen,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.darkGreen,
            ),
          ),
        ),
        const SizedBox(width: 9),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSelector() {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.softGreen,
        border: Border.all(color: AppColors.grayGreen),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.pets,
            color: AppColors.darkGreen,
            size: 27,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedService,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.darkGreen,
                ),
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGreen,
                ),
                items: _services.map((service) {
                  return DropdownMenuItem(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedService = value;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceInformation() {
    return Row(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: AppColors.grayGreen.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            _serviceIcon,
            size: 43,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _serviceDescription,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 15,
                    color: Color(0xFF8BAA55),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '4.8',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '(1.2k reseñas)',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPetSelector() {
    final selectedPet = _pets.firstWhere(
      (pet) => pet['name'] == _selectedPet,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.softGreen,
        border: Border.all(color: AppColors.grayGreen),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.pets,
            size: 27,
            color: AppColors.darkGreen,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedPet,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.darkGreen,
                ),
                items: _pets.map((pet) {
                  return DropdownMenuItem<String>(
                    value: pet['name'],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pet['name']!,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkGreen,
                          ),
                        ),
                        Text(
                          pet['details']!,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPet = value;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Row(
      children: List.generate(5, (index) {
        final date = DateTime.now().add(Duration(days: index));
        final isSelected =
            date.year == _selectedDate.year &&
            date.month == _selectedDate.month &&
            date.day == _selectedDate.day;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              height: 69,
              margin: EdgeInsets.only(right: index == 4 ? 0 : 7),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : Colors.white,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.grayGreen,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weekday(date.weekday),
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                      color: isSelected
                          ? Colors.white70
                          : AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    date.day.toString().padLeft(2, '0'),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : AppColors.darkGreen,
                    ),
                  ),
                  Text(
                    _month(date.month),
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                      color: isSelected
                          ? Colors.white70
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTimeSelector() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _times.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 7,
        crossAxisSpacing: 8,
        childAspectRatio: 2.55,
      ),
      itemBuilder: (context, index) {
        final time = _times[index];
        final isSelected = time == _selectedTime;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTime = time;
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white,
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.grayGreen,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: isSelected
                    ? Colors.white
                    : AppColors.darkGreen,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfirmation() {
    final pet = _pets.firstWhere(
      (item) => item['name'] == _selectedPet,
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: AppColors.softGreen,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Expanded(
            child: _summaryItem(
              Icons.pets,
              'Mascota',
              _selectedPet,
            ),
          ),
          Expanded(
            child: _summaryItem(
              Icons.calendar_today_outlined,
              'Fecha',
              _formattedDate(_selectedDate),
            ),
          ),
          Expanded(
            child: _summaryItem(
              Icons.access_time,
              'Hora',
              _selectedTime,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.primary,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkGreen,
                ),
              ),
            ],
          ),
        ),
      ],
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
        if (index == 0) {
          Navigator.pop(context);
        } else if (index != 3) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Esta sección estará disponible próximamente.'),
            ),
          );
        }
      },
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
                vertical: 10,
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
                    onPressed: () => Navigator.pop(context),
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
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                      label: Text(
                        'Volver',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),

                    const SizedBox(height: 12),

                    _buildServiceSelector(),

                    const SizedBox(height: 16),

                    _buildServiceInformation(),

                    const SizedBox(height: 16),
                    const Divider(color: AppColors.grayGreen),
                    const SizedBox(height: 14),

                    Text(
                      'Crear reserva',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkGreen,
                      ),
                    ),
                    Text(
                      'Selecciona la información para agendar tu cita',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 18),

                    _sectionTitle('1', 'Selecciona tu mascota'),
                    const SizedBox(height: 10),
                    _buildPetSelector(),

                    const SizedBox(height: 17),

                    _sectionTitle('2', 'Elige la fecha'),
                    const SizedBox(height: 10),
                    _buildDateSelector(),

                    const SizedBox(height: 17),

                    _sectionTitle('3', 'Selecciona el horario'),
                    const SizedBox(height: 10),
                    _buildTimeSelector(),

                    const SizedBox(height: 17),

                    _sectionTitle('4', 'Confirma tu reserva'),
                    const SizedBox(height: 10),
                    _buildConfirmation(),

                    const SizedBox(height: 17),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: _confirmReservation,
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Reservar cita',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
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
