import UIKit

fileprivate let reuseIdentifier = "ProductListCell"

class ProductsListViewController: UITableViewController {

    var presenter : PListViewToPresenterProtocol?
    var transactions = Transactions()
    var rates = Rates()
    var productsItemCellVO = ProductListItemsCellVO()
    var productVO: ProductVO?
    var productsVO = [ProductVO]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setUpData()
    }

    private func setUpData() {
        presenter?.getTransactionsData()
        presenter?.getRatesData()
        presenter?.getTransactionsAndRatesData()
    }

    private func setupLayout() {
        navigationItem.title = AppConstants.productListNavTitle
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductListCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsVO.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProductListCell
        cell.initCell(itemVO: productsVO[indexPath.row], VC: self)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        createDetailModule(index: indexPath.row)
    }
    
    private func createDetailModule(index: Int) {
        let selectedProductItem = self.productsVO[index]
        guard let productVO = self.getProductsToDetail(sku: selectedProductItem.sku, products: self.productsVO),
              let navController = self.navigationController else {return}
        ProductDetailRtr.createModule(navController: navController, productVO: productVO)
    }

}


extension ProductsListViewController : PListPresenterToViewProtocol {
    
    func getProductsToDetail(sku: String, products: [ProductVO]) -> ProductVO? {
        return self.presenter?.getProductToDetail(sku: sku, products: products)
    }
    
    func getProducts(products: [ProductVO]) {
        self.productsVO = products
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getProductTransactions(sku: String) -> ProductVO? {
        self.presenter?.getProductWithAllTransactions(transactions: self.transactions, sku: sku)
    }
    
    func getTransactions(transactions: [Transaction]) {
        self.transactions = transactions
    }
    
    func listTransactionsType(itemsCellVO: ProductListItemsCellVO) {
        self.productsItemCellVO = itemsCellVO
    }
    
    func getRates(rates: [Rate]) {
        self.rates = rates
    }
    
    func error(message: String) {
        // Create Alert or UI Stuff
        print(message)
    }
    
}
