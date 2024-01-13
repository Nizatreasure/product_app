part of '../pages/account_info_page.dart';

Widget _buildNameField(BuildContext context) {
  return BlocBuilder<AccountInfoBloc, AccountInfoState>(
    builder: (_, state) {
      return CustomTextInputField(
        hintText: StringManager.fullName,
        fieldName: StringManager.name,
        textEditingController: context.read<AccountInfoBloc>().nameController,
        onChanged: (val) {
          context.read<AccountInfoBloc>().add(AccountInfoNameChangedEvent(val));
        },
      );
    },
  );
}

Widget _buildEmailField(BuildContext context) {
  return BlocBuilder<AccountInfoBloc, AccountInfoState>(
    builder: (_, state) {
      return CustomTextInputField(
        fieldName: StringManager.emailAddress,
        hintText: StringManager.enterEmailAddress,
        textEditingController: context.read<AccountInfoBloc>().emailController,
        textCapitalization: TextCapitalization.none,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        keyboardType: TextInputType.emailAddress,
        onChanged: (val) {
          context
              .read<AccountInfoBloc>()
              .add(AccountInfoEmailChangedEvent(val));
        },
      );
    },
  );
}
