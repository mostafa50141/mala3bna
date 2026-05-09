# Research & Decisions: Player Profile Screen

## User Profile Static UI

- **Decision**: Create a UI-only profile screen without state management (Cubit/Bloc) or HTTP integration for the primary iteration.
- **Rationale**: Functional requirements strictly state "static dummy data only". This allows immediate validation of the UI structure, adhering to the Clean Architecture layout specified.
- **Alternatives considered**: Connecting immediately to `AuthCubit` or user profile APIs. Rejected due to explicit task constraints.

## Component Sizing & Styling

- **Decision**: Utilize `AppColors` for text and backgrounds (specifically `colorBtnAndCard` and `primaryColor`), and rely on styling from `Style` or general predefined widgets.
- **Rationale**: Sticking to the defined system ensures visual consistency and prevents accidental drift through custom hardcoded constants, following the success criteria.