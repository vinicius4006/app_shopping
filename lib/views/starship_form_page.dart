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
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

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
        _formData['price'] = starship.price;
        _formData['description'] = starship.description;
        _formData['image'] = starship.imageUrl;

        _imageUrlController.text = starship.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<StarshipList>().saveStarship(_formData);
      Navigator.pop(context);
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
      body: Padding(
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
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty || value.trim().length < 4) {
                      return '* Nome inválido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['price']?.toString(),
                  decoration: const InputDecoration(labelText: 'Preço'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocus,
                  onSaved: (price) =>
                      _formData['price'] = double.parse(price ?? '0'),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  },
                  validator: (value) {
                    RegExp regExp = RegExp(r"^[+]?\d*\.?\d*$");
                    if (value!.isEmpty || !regExp.hasMatch(value)) {
                      return '* Preço invalido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['description']?.toString(),
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocus,
                  onSaved: ((description) =>
                      _formData['description'] = description ?? ''),
                  validator: ((value) {
                    if (value!.trim().isEmpty || value.trim().length < 6) {
                      return 'Descrição inválida';
                    }
                    return null;
                  }),
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
                        onSaved: (image) => _formData['image'] = image ?? '',
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
                          border: Border.all(color: Colors.grey, width: 1)),
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
