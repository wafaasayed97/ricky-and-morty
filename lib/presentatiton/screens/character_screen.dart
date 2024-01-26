import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic/cubit/character_cubit.dart';
import '../../business_logic/cubit/character_state.dart';
import '../../costants/mycolor.dart';
import '../../data/models/character.dart';
import '../widgets/characteritem.dart';

class CharacterSrceen extends StatefulWidget {
  const CharacterSrceen({Key? key}) : super(key: key);

  @override
  State<CharacterSrceen> createState() => _CharacterSrceenState();
}

class _CharacterSrceenState extends State<CharacterSrceen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final searchTextController = TextEditingController();

  Widget _buildSearchedField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.white,
      decoration: const InputDecoration(
          hintText: 'Find a Character',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white, fontSize: 18)),
      style: const TextStyle(color: Colors.white, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearching();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.white,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearching,
            icon: const Icon(
              Icons.search,
              color: MyColors.white,
            )),
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearching;
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearching() {
    setState(() {
      searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacter();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget buildLoadedListWidget() {
    log(allCharacters.toString());
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: searchTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        itemBuilder: (ctx, index) {
          return CharacterItem(
            character: searchTextController.text.isEmpty
                ? allCharacters[index]
                : searchedForCharacters[index],
          );
        });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.darkTeal,
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: MyColors.white),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Can't Connect...Check Internet",
              style: TextStyle(fontSize: 18, color: MyColors.black),
            ),
            Image.asset('assets/images/going_offline.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          title: _isSearching ? _buildSearchedField() : _buildAppBarTitle(),
          backgroundColor: MyColors.darkTeal,
          actions: _buildAppBarActions(),
          leading: _isSearching
              ? const BackButton(
                  color: MyColors.white,
                )
              : Container()),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
