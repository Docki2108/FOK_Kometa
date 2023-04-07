import 'package:graphql_flutter/graphql_flutter.dart';

import 'constant.dart';

class GRaphQLProvider {
  static GraphQLClient client = GraphQLClient(
    link: HttpLink(GRAPHQL_LINK, defaultHeaders: {
      'content-type': 'application/json',
      'x-hasura-admin-secret': HASURA_PASSWORD
    }),
    cache: GraphQLCache(),
  );
}
