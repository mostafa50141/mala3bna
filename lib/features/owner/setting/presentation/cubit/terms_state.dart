enum TermsStatus { initial, accepting, accepted }

class TermsState {
  /// Whether the user has scrolled to (or past) the bottom of the content.
  final bool hasReadToBottom;

  /// Whether the user has explicitly tapped "Accept & Continue".
  final TermsStatus status;

  const TermsState({
    this.hasReadToBottom = false,
    this.status = TermsStatus.initial,
  });

  bool get canAccept => hasReadToBottom;

  TermsState copyWith({
    bool? hasReadToBottom,
    TermsStatus? status,
  }) {
    return TermsState(
      hasReadToBottom: hasReadToBottom ?? this.hasReadToBottom,
      status: status ?? this.status,
    );
  }
}
