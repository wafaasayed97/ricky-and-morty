import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../business_logic/cubit/character_cubit.dart';
import '../../business_logic/cubit/character_state.dart';
import '../../costants/mycolor.dart';
import '../../data/models/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliversAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: MyColors.teal,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name!,
          style: const TextStyle(
            color: MyColors.white,
          ),
        ),
        background: Hero(
            tag: character.id ?? 0,
            child: Image.network(
              character.image!,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
            text: title,
            style: const TextStyle(
                color: MyColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        TextSpan(
            text: value,
            style: const TextStyle(color: MyColors.black, fontSize: 20)),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.teal,
      height: 30,
      endIndent: endIndent,
      thickness: 4,
    );
  }

  Widget checkIfQuotesLoaded(state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quote;
    if (quotes.length != 0) {
      int randomQuote = Random().nextInt(quotes.length);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.start,
          style:  TextStyle(
            fontSize: 20.0,
            color: MyColors.black,
            shadows: [Shadow(
                blurRadius: 1, offset: Offset(0, 0), color: MyColors.darkTeal)]
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              TypewriterAnimatedText(quotes[randomQuote].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.darkTeal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getCharacterQuotes('happiness');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliversAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo("Status : ", character.status!),
                    buildDivider(290),
                    characterInfo("Species : ", character.species!),
                    buildDivider(275),
                    characterInfo("Gender : ", character.gender!),
                    buildDivider(280),
                    characterInfo("Location : ", character.location!.name!),
                    buildDivider(270),
                    characterInfo("Episode : ", character.episode!.join(" , ")),
                    buildDivider(276),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharacterCubit, CharacterState>(
                        builder: (context, state) {
                      return checkIfQuotesLoaded(state);
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 500,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
