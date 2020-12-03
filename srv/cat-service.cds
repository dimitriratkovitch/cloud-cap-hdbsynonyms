using { my.bookshop} from '../db/data-model';
using { core } from '../db/common-data-model';


service CatalogService @(requires:'authenticated-user'){
  entity Books @readonly      as projection on bookshop.Books;
  entity Authors @readonly    as projection on bookshop.Authors;
  entity Orders @insertonly   as projection on bookshop.Orders;
  entity CurrenciesViaView    as projection on core.Currencies_for_view;
  entity StatesViaView        as projection on core.States_for_view;
  entity CurrenciesViaSynonym as projection on bookshop.Currencies_Synonym;
  entity StatesViaSynonym     as projection on bookshop.States_Synonym;
}