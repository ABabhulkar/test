import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:sim_frontend/model/create_user_model.dart';
import 'package:sim_frontend/services/create_user_response.dart';
import 'package:sim_frontend/widgets/sim_button_widget.dart';
import 'package:sim_frontend/widgets/text_input_field.dart';

import '../services/login_call.dart';

export 'package:sim_frontend/model/create_user_model.dart';

class CreateUserPageWidget extends StatefulWidget {
  const CreateUserPageWidget({super.key});

  @override
  State<CreateUserPageWidget> createState() => _CreateUserPageWidgetState();
}

class _CreateUserPageWidgetState extends State<CreateUserPageWidget>
    with TickerProviderStateMixin {
  late CreateUserModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: 0,
          end: 1,
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
        ),
        TiltEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 400.ms,
          begin: const Offset(0, 0.524),
          end: const Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateUserModel());

    _model.userNameController ??= TextEditingController();
    _model.userNameFocusNode ??= FocusNode();

    _model.emailAddressController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.passwordConfirmController ??= TextEditingController();
    _model.passwordConfirmFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: const AlignmentDirectional(0, -1),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primaryBackground,
                            FlutterFlowTheme.of(context).primary
                          ],
                          stops: const [0, 1],
                          begin: const AlignmentDirectional(1, 0),
                          end: const AlignmentDirectional(-1, 0),
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 570,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: const AlignmentDirectional(0, -1),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 140,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                  ),
                                ),
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 12, 0),
                                        child: Icon(
                                          Icons.flourescent_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 44,
                                        ),
                                      ),
                                      Text(
                                        'SimProject',
                                        style: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .override(
                                              fontFamily: 'Outfit',
                                              letterSpacing: 0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 32),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Create an account',
                                        style: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .override(
                                              fontFamily: 'Outfit',
                                              letterSpacing: 0,
                                            ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 4, 0, 24),
                                        child: Text(
                                          'Let\'s get started by filling out the form below.',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                letterSpacing: 0,
                                              ),
                                        ),
                                      ),
                                      TextInputField(
                                        textLable: 'Username',
                                        controller: _model.userNameController,
                                        focusNode: _model.userNameFocusNode,
                                        textInputType: TextInputType.name,
                                        validator: _model
                                            .userNameControllerValidator
                                            .asValidator(context),
                                        autofillHint: AutofillHints.username,
                                      ),
                                      TextInputField(
                                        textLable: 'Email',
                                        controller:
                                            _model.emailAddressController,
                                        focusNode: _model.emailAddressFocusNode,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        validator: _model
                                            .emailAddressControllerValidator
                                            .asValidator(context),
                                        autofillHint: AutofillHints.email,
                                      ),
                                      TextInputField(
                                        textLable: 'Password',
                                        controller: _model.passwordController,
                                        focusNode: _model.passwordFocusNode,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        validator: _model
                                            .passwordControllerValidator
                                            .asValidator(context),
                                        autofillHint: AutofillHints.password,
                                        obsureText: !_model.passwordVisibility,
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _model.passwordVisibility =
                                                !_model.passwordVisibility,
                                          ),
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      TextInputField(
                                        textLable: 'Confirm Password',
                                        controller:
                                            _model.passwordConfirmController,
                                        focusNode:
                                            _model.passwordConfirmFocusNode,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        validator: _model
                                            .passwordConfirmControllerValidator
                                            .asValidator(context),
                                        autofillHint: AutofillHints.password,
                                        obsureText:
                                            !_model.passwordConfirmVisibility,
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => _model
                                                    .passwordConfirmVisibility =
                                                !_model
                                                    .passwordConfirmVisibility,
                                          ),
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordConfirmVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(1, -1),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 16),
                                          child: SimButtonWidget(
                                            onPressed: createUser,
                                            text: 'Create Account',
                                          ),
                                        ),
                                      ),

                                      // You will have to add an action on this rich text to go to your login page.
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 12, 0, 12),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await Navigator.pushNamed(
                                                context, '/login');
                                            // context.pushNamed(
                                            //   'auth_3_Login',
                                            //   extra: <String, dynamic>{
                                            //     kTransitionInfoKey:
                                            //         TransitionInfo(
                                            //       hasTransition: true,
                                            //       transitionType:
                                            //           PageTransitionType.fade,
                                            //       duration:
                                            //           Duration(milliseconds: 0),
                                            //     ),
                                            //   },
                                            // );
                                          },
                                          child: RichText(
                                            textScaler: MediaQuery.of(context)
                                                .textScaler,
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text:
                                                      'Already have an account? ',
                                                  style: TextStyle(),
                                                ),
                                                TextSpan(
                                                  text: 'Sign In here',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        fontSize: 16,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                )
                                              ],
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: 20,
                                        thickness: 1,
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation']!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createUser() async {
    //TODO: Make effective use of validator in text input field and replace SnackBar
    var data = _model.getValidatedData();
    var error = data.values.first;
    if (kDebugMode) {
      print('Signup button pressed ...');
      print('Data: $data');
    }
    if (error == 'Success') {
      data.remove('error');
      CreateUserResponse response = await ApiCalls.createUser(data);
      if (response.error == 'Success') {
        error = null;
        await Navigator.pushNamed(
          context,
          '/home',
        );
      } else {
        error = response.error;
      }
    }
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
    }
  }
}
