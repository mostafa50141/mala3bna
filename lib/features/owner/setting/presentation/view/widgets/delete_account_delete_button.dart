import 'package:flutter/material.dart';

/// Red "Delete Account" button with loading spinner and enabled/disabled states.
class DeleteAccountDeleteButton extends StatelessWidget {
  final bool isLoading;
  final bool canSubmit;
  final VoidCallback onPressed;

  const DeleteAccountDeleteButton({
    super.key,
    required this.isLoading,
    required this.canSubmit,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: canSubmit ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canSubmit
              ? Colors.redAccent.shade700
              : Colors.redAccent.shade700.withValues(alpha: 0.35),
          disabledBackgroundColor:
              Colors.redAccent.shade700.withValues(alpha: 0.25),
          foregroundColor: Colors.white,
          elevation: canSubmit ? 4 : 0,
          shadowColor: Colors.redAccent.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : const Text(
                  key: ValueKey('label'),
                  'Delete Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
        ),
      ),
    );
  }
}
