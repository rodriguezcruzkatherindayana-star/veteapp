import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isClient = true;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
    }
  }

  void _exploreDemo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Próximamente estará disponible la demostración.'),
      ),
    );
  }
  void _register() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Próximamente estará disponible el registro.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 90,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogo(),

                const SizedBox(height: 84),

                _buildWelcome(),

                const SizedBox(height: 24),

                _buildUserTypeSelector(),

                const SizedBox(height: 29),

                _buildLoginForm(),

                const SizedBox(height: 23),

                _buildLoginButton(),

                const SizedBox(height: 18),

                _buildDemoButton(),

                const SizedBox(height: 30),

                _buildRegisterLink(),

                const SizedBox(height: 55),

                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // LOGO
  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.lightGreen,
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(Icons.pets, color: AppColors.primary, size: 25),
        ),
        const SizedBox(width: 11),
        Text(
          'VeteApp.',
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  // BIENVENIDA
  Widget _buildWelcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 10, height: 1, color: AppColors.primary),
            const SizedBox(width: 7),
            Text(
              'UN ESPACIO PARA ELLOS',
              style: GoogleFonts.poppins(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                color: AppColors.primary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Text(
          'Qué bueno tenerte de vuelta.',
          style: GoogleFonts.poppins(
            fontSize: 29,
            height: 1.28,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 11),

        Text(
          'Todo el cuidado que tu mejor amigo merece, '
          'a un clic de distancia.',
          style: GoogleFonts.poppins(
            fontSize: 13,
            height: 1.55,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // SELECTOR CLIENTE / PROVEEDOR
  Widget _buildUserTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: _userTypeButton(
            title: 'Soy cliente',
            icon: Icons.favorite_border,
            selected: _isClient,
            onTap: () {
              setState(() {
                _isClient = true;
              });
            },
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _userTypeButton(
            title: 'Soy proveedor',
            icon: Icons.add_box_outlined,
            selected: !_isClient,
            onTap: () {
              setState(() {
                _isClient = false;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _userTypeButton({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: selected ? AppColors.softGreen : Colors.white,
        foregroundColor: selected ? AppColors.primary : AppColors.textSecondary,
        minimumSize: const Size(0, 51),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        side: BorderSide(
          color: selected ? const Color(0xFF77BB75) : AppColors.grayGreen,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 19),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FORMULARIO
  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Correo electrónico'),

          const SizedBox(height: 7),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            decoration: const InputDecoration(
              hintText: 'tu@correo.com',
              prefixIcon: Icon(Icons.mail_outline, size: 19),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Ingresa tu correo electrónico';
              }

              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

              if (!emailRegex.hasMatch(value.trim())) {
                return 'Ingresa un correo válido';
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          _buildLabel('Contraseña'),

          const SizedBox(height: 7),

          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _login(),
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Mínimo 6 caracteres',
              prefixIcon: const Icon(Icons.shield_outlined, size: 19),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 19,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu contraseña';
              }

              if (value.length < 6) {
                return 'La contraseña debe tener mínimo 6 caracteres';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  // BOTÓN INICIAR SESIÓN
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: AppColors.primary.withValues(alpha: 0.20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              'Iniciar sesión',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward, size: 20),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  // DEMOSTRACIÓN
  Widget _buildDemoButton() {
    return Center(
      child: TextButton(
        onPressed: _exploreDemo,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Explorar la demo sin registrarme',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 9),
            const Icon(Icons.arrow_forward, size: 14, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  // REGISTRO
  Widget _buildRegisterLink() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            '¿Aún no tienes una cuenta? ',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          GestureDetector(
            onTap: _register,
            child: Text(
              'Regístrate gratis',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // PIE DE PÁGINA
  Widget _buildFooter() {
    return Center(
      child: Text(
        '© 2025 VeteApp · Hecho para quienes aman a sus mascotas',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(fontSize: 9, color: AppColors.textSecondary),
      ),
    );
  }
}
