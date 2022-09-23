import 'package:flutter/material.dart';
import 'package:gerenciamento_estado/models/starship.dart';
import 'package:gerenciamento_estado/models/starship_list.dart';
import 'package:provider/provider.dart';

class StarshipFormPage extends StatefulWidget {
  const StarshipFormPage({super.key});

  @override
  State<StarshipFormPage> createState() => _StarshipFormPageState();
}

class _StarshipFormPageState extends State<StarshipFormPage> {
  final _creditsFocus = FocusNode();
  final _modelFocus = FocusNode();
  final _manufacturerFocus = FocusNode();
  final _sizeFocus = FocusNode();
  final _passengersFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        final starship = args as Starship;
        _formData['id'] = starship.id;
        _formData['name'] = starship.name;
        _formData['model'] = starship.model;
        _formData['manufacturer'] = starship.manufacturer;
        _formData['cost_in_credits'] = starship.costInCredits;
        _formData['length'] = starship.size;
        _formData['passengers'] = starship.passengers;
        _formData['imageUrl'] = starship.imageUrl;

        _imageUrlController.text = starship.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _creditsFocus.dispose();
    _modelFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    debugPrint('Imagem atualizada');
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);
      try {
        await context.read<StarshipList>().saveStarship(_formData);
        if (mounted) {
          Navigator.pop(context);
        }
      } catch (error) {
        await showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Ocorreu um erro!'),
                  content: Text(error.toString()),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'))
                  ],
                ));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário da Starship'),
        actions: [
          IconButton(onPressed: _submitForm, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                        textInputAction: TextInputAction.next,
                        onSaved: (name) => _formData['name'] = name ?? '',
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_modelFocus);
                        },
                        validator: (value) {
                          if (value!.trim().isEmpty ||
                              value.trim().length < 4) {
                            return '* Nome inválido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['model']?.toString(),
                        decoration: const InputDecoration(labelText: 'Modelo'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        focusNode: _modelFocus,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_manufacturerFocus),
                        onSaved: ((description) =>
                            _formData['model'] = description ?? ''),
                        validator: ((value) {
                          if (value!.trim().isEmpty ||
                              value.trim().length < 6) {
                            return 'Modelo inválido';
                          }
                          return null;
                        }),
                      ),
                      TextFormField(
                        initialValue: _formData['manufacturer']?.toString(),
                        decoration:
                            const InputDecoration(labelText: 'Produzido'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        focusNode: _manufacturerFocus,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_creditsFocus),
                        onSaved: ((description) =>
                            _formData['manufacturer'] = description ?? ''),
                        validator: ((value) {
                          if (value!.trim().isEmpty ||
                              value.trim().length < 6) {
                            return 'Produtor inválido';
                          }
                          return null;
                        }),
                      ),
                      TextFormField(
                        initialValue: _formData['cost_in_credits']?.toString(),
                        decoration: const InputDecoration(labelText: 'Credits'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _creditsFocus,
                        onSaved: (credits) => _formData['cost_in_credits'] =
                            int.parse(credits ?? '0'),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_sizeFocus);
                        },
                        validator: (value) {
                          RegExp regExp = RegExp(r"^\d+$");
                          if (value!.isEmpty || !regExp.hasMatch(value)) {
                            return '* Credits inválido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['length']?.toString(),
                        decoration: const InputDecoration(labelText: 'Tamanho'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _sizeFocus,
                        onSaved: (size) =>
                            _formData['length'] = double.parse(size ?? '0'),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_passengersFocus);
                        },
                        validator: (value) {
                          RegExp regExp = RegExp(r"^[+]?\d*\.?\d*$");
                          if (value!.isEmpty || !regExp.hasMatch(value)) {
                            return '* Tamanho inválido';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['passengers']?.toString(),
                        decoration:
                            const InputDecoration(labelText: 'Passageiros'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _passengersFocus,
                        onSaved: (credits) =>
                            _formData['passengers'] = int.parse(credits ?? '0'),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_imageUrlFocus);
                        },
                        validator: (value) {
                          RegExp regExp = RegExp(r"^\d+$");
                          if (value!.isEmpty || !regExp.hasMatch(value)) {
                            return '* Número inválido';
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Url da imagem',
                              ),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.url,
                              focusNode: _imageUrlFocus,
                              controller: _imageUrlController,
                              onSaved: (image) =>
                                  _formData['imageUrl'] = image ?? '',
                              validator: (value) {
                                if (!isValidImageUrl(value ?? '')) {
                                  return '* URL inválida';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) => _submitForm(),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(top: 10, left: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            alignment: Alignment.center,
                            child: !isValidImageUrl(_imageUrlController.text)
                                ? const Text('Informe a Url')
                                : Image.network(
                                    _imageUrlController.text,
                                    width: 100,
                                    height: 100,
                                  ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
    );
  }
}
