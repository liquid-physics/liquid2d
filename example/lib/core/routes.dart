import 'package:flutter/material.dart';
import 'package:liquid_example/ball_fall/ball_fall.dart';
import 'package:liquid_example/bouncy_hexagon/bouncy_hexagon.dart';
import 'package:liquid_example/buoyancy/buoyancy.dart';
import 'package:liquid_example/chain/chain.dart';
import 'package:liquid_example/contact_graph/contact_graph.dart';
import 'package:liquid_example/convex/convex.dart';
import 'package:liquid_example/crane/crane.dart';
import 'package:liquid_example/joint/joint.dart';
import 'package:liquid_example/logo_smash/logo_smash.dart';
import 'package:liquid_example/one_way/one_way.dart';
import 'package:liquid_example/planet/planet.dart';
import 'package:liquid_example/player/player.dart';
import 'package:liquid_example/plink/plink.dart';
import 'package:liquid_example/pump/pump.dart';
import 'package:liquid_example/pyramid_stack/pyramid_stack.dart';
import 'package:liquid_example/pyramid_topple/pyramid_topple.dart';
import 'package:liquid_example/query/query.dart';
import 'package:liquid_example/shatter/shatter.dart';
import 'package:liquid_example/slice/slice.dart';
import 'package:liquid_example/springies/springies.dart';
import 'package:liquid_example/sticky/sticky.dart';
import 'package:liquid_example/tank/tank.dart';
import 'package:liquid_example/theo_jansen/theo_jansen.dart';
import 'package:liquid_example/tumble/tumble.dart';
import 'package:liquid_example/unicycle/unicyle.dart';

import 'fade_page.dart';

var routes = <String, (Widget, String)>{
  BallFall.route: (const BallFall(), 'A. Ball Fall'),
  LogoSmash.route: (const LogoSmash(), 'B. Logo Smash'),
  PyramidStack.route: (const PyramidStack(), 'C. Pyramid Stack'),
  Plink.route: (const Plink(), 'D. Plink'),
  BouncyHexagon.route: (const BouncyHexagon(), 'E. Bouncy Hexagon'),
  Tumble.route: (const Tumble(), 'F. Tumble'),
  PyramidTopple.route: (const PyramidTopple(), 'G. Pyramid Topple'),
  Planet.route: (const Planet(), 'H. Planet'),
  Springies.route: (const Springies(), 'I. Springies'),
  Pump.route: (const Pump(), 'J. Pump'),
  TheoJansen.route: (const TheoJansen(), 'K. Theo Jansen'),
  Query.route: (const Query(), 'L. Query'),
  OneWay.route: (const OneWay(), 'M. One Way'),
  Joint.route: (const Joint(), 'N. Joint and Constraint'),
  Tank.route: (const Tank(), 'O. Tank'),
  Chain.route: (const Chain(), 'P. Chain'),
  Crane.route: (const Crane(), 'Q. Crane'),
  ContactGraph.route: (const ContactGraph(), 'R. Contact Graph'),
  Buoyancy.route: (const Buoyancy(), 'S. Buoyancy'),
  Player.route: (const Player(), 'T. Player'),
  Slice.route: (const Slice(), 'U. Slice'),
  Convex.route: (const Convex(), 'V. Convex'),
  Unicycle.route: (const Unicycle(), 'W. Unicycle'),
  Sticky.route: (const Sticky(), 'X. Sticky'),
  Shatter.route: (const Shatter(), 'Y. Shatter'),
};

var index = 0;

void next() => index++;
void prev() => index--;

var routeGen = (RouteSettings settings, BuildContext context) {
  if (settings.name == routes.entries.elementAt(index % routes.length).key) {
    return FadePageRoute(builder: (context) => routes.entries.elementAt(index % routes.length).value.$1, settings: settings);
  }
};
